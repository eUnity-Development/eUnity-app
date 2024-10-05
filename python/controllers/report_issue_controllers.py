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
from json_models.json_issue_report import JsonIssueReport

router = APIRouter()

db = DBManager.db
collection = db["issue_reports"]

security = HTTPBearer()

@router.get("/report_issue/get_report")
async def get_report(request: Request):
    if not hasattr(request.state, 'user_id'):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is None:
        return JSONResponse(status_code=400, content={"response": "Could not find an open report from the user!"})
    report = IssueReport(**search)
    print("here",report.to_json())
    return JSONResponse(status_code=200, content=report.to_json())



@router.post("/report_issue/add_report")
async def add_report(request: Request, report: JsonIssueReport):
    if not hasattr(request.state, 'user_id'):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is not None:
        return JSONResponse(status_code=400, content={"response": "User already has an open report."})
    object_id = ObjectId()
    media_choice = [] if report.media_files is None else report.media_files
    new_report = IssueReport(
        user_id=user_id,
        description=report.description,
        email=report.email,
        submitted=False,
        media_files=media_choice,
        updated_at=datetime.now()
    )
    collection.insert_one(new_report.dict())
    return JSONResponse(status_code=200, content={"response": "Successfully Created Report"})

@router.patch("/report_issue/update_report")
async def update_report(request: Request, report: dict):
    if not hasattr(request.state, 'user_id'):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is None:
        return JSONResponse(status_code=400, content={"response": "Could not find existing report."})
    old_report = IssueReport(**search)
    report_id = old_report.id
    for key, value in report.items():
        if key not in ["user_id", "ID"]:
            if value is not None:
                collection.update_one({"_id": report_id}, {"$set": {key: value}})
    collection.update_one({"_id": report_id}, {"$set": {"updated_at": datetime.now()}})
    return JSONResponse(status_code=200, content={"response": "Successfully Patched Existing Report"})

@router.patch("/report_issue/submit_report")
async def submit_report(request: Request):
    if not hasattr(request.state, 'user_id'):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id
    search = collection.find_one({"user_id": user_id, "submitted": False})
    if search is None:
        return JSONResponse(status_code=400, content={"response": "Could not find an open report from the user!"})
    report = IssueReport(**search)
    if report.description == "":
        return JSONResponse(status_code=400, content={"response": "Empty Description is not allowed."})
    collection.update_one({"_id": report.id}, {"$set": {"submitted": True}})
    return JSONResponse(status_code=200, content={"response": "Submitted Report."})
