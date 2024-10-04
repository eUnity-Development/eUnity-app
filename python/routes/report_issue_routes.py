from fastapi import APIRouter, Depends
from controllers import ReportIssueController

router = APIRouter(prefix="/report")

report_issue_controller = ReportIssueController()

@router.get("/get_report")
async def get_report():
    return report_issue_controller.get_issue()

@router.post("/add_report")
async def add_report():
    return report_issue_controller.add_issue()

@router.patch("/update_report")
async def update_report():
    return report_issue_controller.update_issue()

@router.patch("/submit_report")
async def submit_report():
    return report_issue_controller.submit_report()