from pydantic import BaseModel
from datetime import datetime
from typing import List



class IssueReport(BaseModel):
    id: str
    user_id: str
    description: str
    email: str
    media_files: List[str]
    submitted: bool
    updated_at: datetime
