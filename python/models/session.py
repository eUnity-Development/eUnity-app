from pydantic import BaseModel
from typing import List


class Session(BaseModel):
    session_id: str
    expires_at: int
    created_at: int
    user_id: str
    permissions: List[str]
