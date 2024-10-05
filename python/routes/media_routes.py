from fastapi import APIRouter, Depends
from controllers import media_controllers as media_controller
from fastapi import UploadFile, Request


router = APIRouter(prefix="/media", tags=["Media"])
pubRouter = APIRouter(prefix="/media", tags=["Media"])

@router.post("/user_image")
async def add_user_image(file: UploadFile, request: Request):
    return await media_controller.add_user_image(file, request)


@router.delete("/user_image/{image_id}")
async def delete_user_image(image_id: str, request: Request):
    return await media_controller.delete_user_image(image_id, request)

@router.post("/report_image")
async def add_report_image(file: UploadFile, request: Request):
    return await media_controller.add_report_image(file, request)

@router.get("/report_image/{image_id}")
async def get_report_image(image_id: str, request: Request):
    return await media_controller.get_report_image(image_id, request)

@router.delete("/report_image/{image_id}")
async def delete_report_image(image_id: str, request: Request):
    return await media_controller.delete_report_image(image_id, request)

# public media routes unprotected
@pubRouter.get("/{user_id}/{image_id}")
async def get_image(user_id: int, image_id: int):
    return await media_controller.get_image(user_id, image_id)

@pubRouter.get("/reports/{report_id}/{image_id}")
async def get_report_image(report_id: int, image_id: int):
    return await media_controller.get_report_image(report_id, image_id)