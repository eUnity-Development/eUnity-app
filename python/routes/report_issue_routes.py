from fastapi import APIRouter, Depends
from controllers import report_issue_controllers as report_issue_controller
from json_models.json_issue_report import JsonIssueReport
from fastapi import Request

router = APIRouter(tags=["report_issue"])


@router.get("/get_report")
async def get_report(request: Request):
    return await report_issue_controller.get_report(request)


@router.post("/add_report")
async def add_report(request: Request, report: JsonIssueReport):
    return await report_issue_controller.add_report(request, report)


@router.patch("/update_report")
async def update_report(request: Request, report: dict):
    return await report_issue_controller.update_report(request, report)


@router.patch("/submit_report")
async def submit_report(request: Request):
    return await report_issue_controller.submit_report(request)
