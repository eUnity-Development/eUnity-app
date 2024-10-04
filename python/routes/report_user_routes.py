from fastapi import APIRouter


router = APIRouter()

from controllers import Report_User_controllers

report_user_controllers = Report_User_controllers()

@router.post("/add_report")
async def post_add_report():
    return report_user_controllers.post_add_report()

