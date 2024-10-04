from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import FileResponse
from fastapi.requests import Request
from fastapi.security.utils import get_authorization_scheme
from fastapi.params import Depends
from pydantic import BaseModel
from typing import List
from uuid import uuid4
import os
import asyncio
from pymongo import MongoClient
from pymongo.errors import PyMongoError
import bson

app = FastAPI()


class MediaFiles(BaseModel):
    image_id: str


class IssueReport(BaseModel):
    user_id: str
    submitted: bool
    media_files: List[str]


async def get_db():
    client = MongoClient("mongodb://localhost:27017/")
    db = client["mydatabase"]
    return db


async def get_user_id(request: Request):
    authorization_scheme, token = get_authorization_scheme(request)
    return token


@app.post("/media/user_image")
async def add_user_image(file: UploadFile = File(...), user_id: str = Depends(get_user_id)):
    image_id = str(uuid4())
    try:
        await MediaEncoder.save_to_webp(file, image_id, user_id)
    except Exception as e:
        raise HTTPException(status_code=500, detail="Error Saving to Webp")
    image_id += ".webp"
    db = await get_db()
    user_collection = db["users"]
    user = await user_collection.find_one({"_id": bson.ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=500, detail="Internal Server Error")
    if len(user.get("media_files", [])) >= 9:
        raise HTTPException(status_code=400, detail="User has reached maximum number of images")
    link = f"http://localhost:3200/api/v1/media/{user_id}/{image_id}"
    await user_collection.update_one({"_id": bson.ObjectId(user_id)}, {"$push": {"media_files": link}})
    return {"image_id": image_id}


@app.get("/media/user_image/{image_id}")
async def get_user_image(image_id: str, user_id: str = Depends(get_user_id)):
    return FileResponse(f"images/{user_id}/{image_id}", media_type="image/jpeg")


@app.delete("/media/user_image/{image_id}")
async def delete_user_image(image_id: str, user_id: str = Depends(get_user_id)):
    db = await get_db()
    user_collection = db["users"]
    user = await user_collection.find_one({"_id": bson.ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=500, detail="Internal Server Error")
    await user_collection.update_one({"_id": bson.ObjectId(user_id)}, {"$pull": {"media_files": f"http://localhost:3200/api/v1/media/{user_id}/{image_id}"}})
    os.remove(f"images/{user_id}/{image_id}")
    return {"image_id": image_id}


@app.get("/media/reports/{report_id}/{image_id}")
async def get_report_image(report_id: str, image_id: str):
    return FileResponse(f"images/reports/{report_id}/{image_id}", media_type="image/jpeg")


@app.post("/media/report_image")
async def add_report_image(file: UploadFile = File(...), user_id: str = Depends(get_user_id)):
    extension = os.path.splitext(file.filename)[1]
    report_collection = await get_db()["issue_reports"]
    report = await report_collection.find_one({"user_id": user_id, "submitted": False})
    if report is None:
        raise HTTPException(status_code=400, detail="Could not find existing report.")
    report_id = report["_id"]
    image_id = str(uuid4()) + extension
    await file.save(f"images/reports/{report_id.Hex()}/{image_id}")
    await report_collection.update_one({"_id": report_id}, {"$push": {"media_files": f"http://localhost:3200/api/v1/media/reports/{report_id.Hex()}/{image_id}"}})
    return {"image_id": image_id}


@app.delete("/media/report_image/{image_id}")
async def delete_report_image(image_id: str, user_id: str = Depends(get_user_id)):
    report_collection = await get_db()["issue_reports"]
    report = await report_collection.find_one({"user_id": user_id, "submitted": False})
    if report is None:
        raise HTTPException(status_code=400, detail="Could not find existing report.")
    report_id = report["_id"]
    await report_collection.update_one({"_id": report_id}, {"$pull": {"media_files": f"http://localhost:3200/api/v1/media/reports/{report_id.Hex()}/{image_id}"}})
    os.remove(f"images/reports/{report_id.Hex()}/{image_id}")
    return {"image_id": image_id}


@app.get("/media/reports/{report_id}/{image_id}")
async def get_report_image(report_id: str, image_id: str):
    return FileResponse(f"images/reports/{report_id}/{image_id}", media_type="image/jpeg")
