from fastapi import APIRouter, HTTPException
from fastapi.responses import JSONResponse
from fastapi.params import Query
from fastapi.openapi.utils import get_openapi
from datetime import datetime
from pymongo import MongoClient
from helpers.db_manager import DBManager
from models.feedback import Feedback



# Connect to MongoDB
db = DBManager.db
feedback_collection = db['feedback']

router = APIRouter()



@router.post("/feedback/add")
async def add_feedback(user: str = Query(...), stars: int = Query(...), positive_text: str = Query(...), negative_text: str = Query(...)):
    if user == "" or stars == 0 or stars < 0 or stars > 5 or positive_text == "" or negative_text == "":
        raise HTTPException(status_code=400, detail="Missing required fields!")

    feedback = Feedback(user, stars, positive_text, negative_text, datetime.now())

    try:
        feedback_collection.insert_one(feedback.__dict__)
    except Exception as e:
        raise HTTPException(status_code=400, detail="Error adding feedback!")

    return JSONResponse(status_code=200, content={"response": "Feedback added successfully!"})

@router.get("/feedback/get")
async def get_feedback(user: str = Query(...)):
    try:
        cursor = feedback_collection.find({"user": user})
        feedbacks = [Feedback(**feedback) for feedback in cursor]
        return JSONResponse(status_code=200, content=feedbacks)
    except Exception as e:
        raise HTTPException(status_code=400, detail="Error finding user feedback")

@router.get("/feedback/getall")
async def get_all_feedback():
    try:
        cursor = feedback_collection.find()
        feedbacks = [Feedback(**feedback) for feedback in cursor]
        return JSONResponse(status_code=200, content=feedbacks)
    except Exception as e:
        raise HTTPException(status_code=400, detail="Error finding feedback")
