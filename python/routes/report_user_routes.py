from fastapi import APIRouter
from controllers import report_user_controllers 


router = APIRouter()



@router.post("/add_report")
async def post_add_report():
    return report_user_controllers.post_add_report()

