from pydantic import BaseModel


class Provider(BaseModel):
    name: str
    email: str
    email_verified: bool
    sub: str
