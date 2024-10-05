from pydantic import BaseModel
from typing import List


class JsonUserReport(BaseModel):
    reported_user: str
    rule_violations: List[str]
    report_comments: str