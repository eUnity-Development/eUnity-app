from pydantic import BaseModel
from typing import Optional, Dict
from provider import Provider




class Developer(BaseModel):
    id: Optional[str] = None  # equivalent to *primitive.ObjectID
    email: str
    first_name: str
    last_name: str
    avatar_url: Optional[str] = None
    providers: Dict[str, Provider]

