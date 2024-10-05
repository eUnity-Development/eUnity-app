from typing import List, Optional
from pydantic import BaseModel


class JsonIssueReport(BaseModel):
    description: str
    email: str
    media_files: Optional[List[str]] = None
