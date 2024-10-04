from pydantic import BaseModel
from datetime import datetime


class Feedback(BaseModel):
    user: str
    stars: int
    positive_text: str
    negative_text: str
    submitted_at: datetime

