from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from fastapi.security import HTTPAuthorizationCredentials
from fastapi.security.http import HTTPBearer, HTTPAuthorizationCredentials
from bson import ObjectId
from pymongo import MongoClient
from datetime import datetime
from helpers.db_manager import DBManager
from fastapi import APIRouter
from models.issue_report import IssueReport

router = APIRouter()

db = DBManager.db
collection = db["issue_reports"]

security = HTTPBearer()

@router.get("/report_issue/get_report")
async def get_report(user_id: str):
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is None:
        return JSONResponse(status_code=400, content={"response": "Could not find an open report from the user!"})
    report = IssueReport(**search)
    return report

@router.post("/report_issue/add_report")
async def add_report(request: Request, report: IssueReport):
    user_id = request.headers.get("user_id")
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is not None:
        return JSONResponse(status_code=400, content={"response": "User already has an open report."})
    object_id = ObjectId()
    media_choice = [] if report.MediaFiles is None else report.MediaFiles
    new_report = IssueReport(
        ID=object_id,
        User_ID=user_id,
        IssueDescription=report.IssueDescription,
        Contact_Email=report.Contact_Email,
        Submitted=False,
        MediaFiles=media_choice,
        Updated_At=datetime.now()
    )
    collection.insert_one(new_report.dict())
    return JSONResponse(status_code=200, content={"response": "Successfully Created Report"})

@router.patch("/report_issue/update_report")
async def update_report(request: Request, report: IssueReport):
    user_id = request.headers.get("user_id")
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is None:
        return JSONResponse(status_code=400, content={"response": "Could not find existing report."})
    old_report = IssueReport(**search)
    report_id = old_report.ID
    for key, value in report.dict().items():
        if key not in ["user_id", "ID"]:
            if value is not None:
                collection.update_one({"_id": report_id}, {"$set": {key: value}})
    collection.update_one({"_id": report_id}, {"$set": {"updated_at": datetime.now()}})
    return JSONResponse(status_code=200, content={"response": "Successfully Patched Existing Report"})

@router.patch("/report_issue/submit_report")
async def submit_report(request: Request):
    user_id = request.headers.get("user_id")
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is None:
        return JSONResponse(status_code=400, content={"response": "Could not find an open report from the user!"})
    report = IssueReport(**search)
    if report.IssueDescription == "":
        return JSONResponse(status_code=400, content={"response": "Empty Description is not allowed."})
    collection.update_one({"_id": report.ID}, {"$set": {"submitted": True}})
    return JSONResponse(status_code=200, content={"response": "Submitted Report."})
