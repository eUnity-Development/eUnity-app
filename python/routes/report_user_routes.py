from fastapi import APIRouter
from controllers import report_user_controllers
from fastapi import Request
from json_models.json_user_report import JsonUserReport


router = APIRouter(tags=["report_user"])


@router.post("/add_report")
async def post_add_report(request: Request, report: JsonUserReport):
    return await report_user_controllers.post_add_report(request, report)
