from fastapi import APIRouter, Depends
from controllers import feedback_controllers as feedback_controller


router = APIRouter()

@router.post("/add")
async def add_feedback():
    return feedback_controller.add_feedback()

@router.get("/get")
async def get_feedback():
    return feedback_controller.get_feedback()

@router.get("/getall")
async def get_all_feedback():
    return feedback_controller.get_all_feedback()