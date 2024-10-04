from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime



class UserReport(BaseModel):
    id: str
    reported_user: str
    reported_by: str
    rule_violations: list[str]
    report_comments: str
    reported_at: datetime
