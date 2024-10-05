from pydantic import BaseModel
from datetime import datetime


class Message(BaseModel):
    conversation_id: str
    from_: str
    to: str
    message: str
    created_at: str = datetime.now().isoformat()
    delivered: bool = False
    read: bool = False

    @classmethod
    def new_message(cls, conv_id: str, from_: str, to: str, message: str):
        return cls(
            conversation_id=conv_id,
            from_=from_,
            to=to,
            message=message,
            created_at=datetime.now().isoformat(),
            delivered=False,
            read=False
        )
    
    