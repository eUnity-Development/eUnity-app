from fastapi import File, UploadFile, HTTPException
from fastapi import APIRouter
from fastapi.responses import FileResponse
from fastapi.requests import Request
from fastapi.params import Depends
from uuid import uuid4
import os
from pymongo import MongoClient
from pymongo.errors import PyMongoError
import bson

from helpers.db_manager import DBManager

db = DBManager.db


router = APIRouter()


@router.post("/media/user_image")
async def add_user_image(file: UploadFile, user_id: str):
    pass
    return {"status": "need to implement"}


@router.get("/media/user_image/{image_id}")
async def get_user_image(image_id: str, user_id: str):
    pass
    return {"status": "need to implement"}


@router.delete("/media/user_image/{image_id}")
async def delete_user_image(image_id: str, user_id: str):
    pass
    return {"status": "need to implement"}


@router.get("/media/reports/{report_id}/{image_id}")
async def get_report_image(report_id: str, image_id: str):
    pass
    return {"status": "need to implement"}


@router.post("/media/report_image")
async def add_report_image(file: UploadFile, user_id: str):
    pass
    return {"status": "need to implement"}


@router.delete("/media/report_image/{image_id}")
async def delete_report_image(image_id: str, user_id: str):
   pass 
   return {"status": "need to implement"}


@router.get("/media/reports/{report_id}/{image_id}")
async def get_report_image(report_id: str, image_id: str):
    pass
    return {"status": "need to implement"}
