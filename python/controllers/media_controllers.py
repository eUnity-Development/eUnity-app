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
from helpers.media_helper import ImageHelper
from fastapi.responses import JSONResponse

db = DBManager.db


async def add_user_image(file: UploadFile, request: Request):
    if not hasattr(request.state, "user_id"):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id
    image_id = str(uuid4())

    image = await ImageHelper.uploadImage(file, image_id, user_id)

    ## we save the image in the database images collection
    db["images"].insert_one(image.dict())

    ##update media_files and add image_id to the user
    bson_user_id = bson.ObjectId(user_id)
    user = db["users"].find_one({"_id": bson_user_id})
    user["media_files"].append(image.__dict__)
    db["users"].update_one({"_id": bson_user_id}, {"$set": user})

    return JSONResponse(status_code=200, content=image.to_json())


async def delete_user_image(image_id: str, request: Request):
    ## get from images collection
    ## delete from imagekit
    ## if successful delete from image object and update user object
    if not hasattr(request.state, "user_id"):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id

    response = ImageHelper.deleteImage(image_id)
    print(response)
    db["images"].delete_one({"image_id": image_id})
    bson_user_id = bson.ObjectId(user_id)

    try:
        db["users"].update_one(
            {"_id": bson_user_id}, {"$pull": {"media_files": {"image_id": image_id}}}
        )
    except PyMongoError as e:
        return JSONResponse(
            status_code=400, content={"error": "Unable to delete image"}
        )

    return JSONResponse(status_code=200, content={"response": "Image deleted"})


async def add_report_image(file: UploadFile, request: Request):
    pass
    return {"status": "need to implement"}


async def get_report_image(image_id: str, request: Request):
    pass
    return {"status": "need to implement"}


async def delete_report_image(image_id: str, request: Request):
    pass
    return {"status": "need to implement"}


async def get_image(user_id: str, image_id: str):
    pass
    return {"status": "need to implement"}


async def get_report_image(report_id: str, image_id: str):
    pass
    return {"status": "need to implement"}
