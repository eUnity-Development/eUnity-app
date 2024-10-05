from fastapi import FastAPI, Form, Response
from pydantic import BaseModel
from typing import List
import datetime
from fastapi import Request
from models.user_report import UserReport
from json_models.json_user_report import JsonUserReport
from fastapi import HTTPException
from helpers.db_manager import DBManager


db = DBManager.db


async def post_add_report(request: Request, report: JsonUserReport):
    if not hasattr(request.state, "user_id"):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id

    new_report = UserReport(
        id=user_id,
        reported_user=report.reported_user,
        reported_by=user_id,
        rule_violations=report.rule_violations,
        report_comments=report.report_comments,
        reported_at=datetime.datetime.now(),
    )

    try:

        db["user_reports"].insert_one(new_report.dict())
        return Response(status_code=200, content="Successfully Created Report")
    except Exception as e:
        print(e)
        return Response(status_code=400, content=str(e))
