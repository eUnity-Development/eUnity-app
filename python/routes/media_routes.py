from fastapi import APIRouter, Depends
from controllers import media_controllers as media_controller


router = APIRouter(prefix="/media", tags=["Media"])

@router.post("/user_image")
async def add_user_image():
    return media_controller.add_user_image()

@router.get("/user_image/{image_id}")
async def get_user_image(image_id: int):
    return media_controller.get_user_image(image_id)

@router.delete("/user_image/{image_id}")
async def delete_user_image(image_id: int):
    return media_controller.delete_user_image(image_id)

@router.post("/report_image")
async def add_report_image():
    return media_controller.add_report_image()

@router.get("/report_image/{image_id}")
async def get_report_image(image_id: int):
    return media_controller.get_report_image(image_id)

@router.delete("/report_image/{image_id}")
async def delete_report_image(image_id: int):
    return media_controller.delete_report_image(image_id)

# public media routes unprotected
@router.get("/{user_id}/{image_id}")
async def get_image(user_id: int, image_id: int):
    return media_controller.get_image(user_id, image_id)

@router.get("/reports/{report_id}/{image_id}")
async def get_report_image(report_id: int, image_id: int):
    return media_controller.get_report_image(report_id, image_id)