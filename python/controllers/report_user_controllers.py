from fastapi import FastAPI, Form, Response
from pydantic import BaseModel
from typing import List
import datetime
from bson import ObjectId
from pymongo import MongoClient

app = FastAPI()


class UserReport(BaseModel):
    reported_user: str
    rule_violations: List[str]
    report_comments: str = None


class ReportUserControllers:
    def __init__(self, db: MongoClient):
        self.db = db

    @app.post("/report_user/add_report")
    async def post_add_report(self, reported_user: str = Form(...), rule_violations: List[str] = Form(...), report_comments: str = Form(None), user_id: str = None):
        if user_id is None:
            return Response(status_code=400, content="User ID is required")

        report_data = UserReport(reported_user=reported_user, rule_violations=rule_violations, report_comments=report_comments)

        if not report_data.rule_violations:
            return Response(status_code=400, content="Rule Violations are required")
        if not report_data.reported_user:
            return Response(status_code=400, content="Reported User is required")

        new_report = {
            "_id": ObjectId(),
            "reported_user": report_data.reported_user,
            "reported_by": user_id,
            "rule_violations": report_data.rule_violations,
            "report_comments": report_data.report_comments,
            "reported_at": datetime.datetime.utcnow(),
        }

        try:
            self.db["user_reports"].insert_one(new_report)
            return Response(status_code=200, content="Successfully Created Report")
        except:
            return Response(status_code=400, content="Unable to Insert Report")

# Initialize the controller with a MongoDB client
controller = ReportUserControllers(MongoClient("mongodb://localhost:27017/"))

# Add the controller to the FastAPI app
app.include_router(controller.post_add_report)