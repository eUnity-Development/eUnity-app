from fastapi import FastAPI, WebSocket, Query
from pydantic import BaseModel
import logging
import time
import asyncio

app = FastAPI()

logger = logging.getLogger(__name__)

ws_manager = None  # Initialize WSManager instance


class Message(BaseModel):
    conversation_id: str
    from_user: str
    to_user: str
    message: str


@app.post("/messaging/send")
async def send_message(
    message: str = Query(...), user_id: str = Query(...), to_user_id: str = Query(...)
):
    from_user_id = user_id
    conversation_id = "placeholder"  # Replace with actual conversation ID
    message_obj = Message(
        conversation_id=conversation_id,
        from_user=from_user_id,
        to_user=to_user_id,
        message=message,
    )
    try:
        await ws_manager.send_message(message_obj)
        return {"success": True}
    except Exception as e:
        return {"message": "Error sending message"}, 500


@app.websocket("/messaging/ws")
async def websocket_endpoint(websocket: WebSocket, user_id: str = Query(...)):
    logger.info(f"User ID: {user_id}")
    await websocket.accept()
    ws_manager.add_connection(user_id, websocket)
    while True:
        await websocket.send("Ping")
        await websocket.receive_text()  # just to keep the connection open
        await asyncio.sleep(5)
