from fastapi import FastAPI, HTTPException, Cookie
from fastapi.responses import JSONResponse
from fastapi.requests import Request
from fastapi.security.utils import get_authorization_scheme_param
from pydantic import BaseModel
from typing import Optional
import uuid
import json
import os
import time
from db_manager import DBManager
from redis import Redis, ConnectionPool
from pymongo import MongoClient
from models.session import Session
from dotenv import load_dotenv


load_dotenv()



# Environment variables
HTTPS_ONLY = os.environ.get("HTTPS_ONLY", "false").lower() == "true"
COOKIE_HOST = os.environ.get("COOKIE_ACCEPT_HOST", "")
VALKEY_ENABLED = os.environ.get("VALKEY_ENABLED", "false").lower() == "true"
VALKEY_URL = os.environ.get("VALKEY_URL", "")
VALKEY_PASS = os.environ.get("VALKEY_PASS", "")

# Redis client
if VALKEY_ENABLED:
    redis_pool = ConnectionPool(host=VALKEY_URL, password=VALKEY_PASS, db=0)
    rdb = Redis(connection_pool=redis_pool)
else:
    rdb = None

# MongoDB client
db = DBManager.client




async def get_session(session_id: str) -> Optional[Session]:
    if VALKEY_ENABLED:
        session = await rdb.get(session_id)
        if session:
            return Session(**json.loads(session))
    else:
        collection = db["session_ids"]
        session = collection.find_one({"session_id": session_id})
        if session:
            return Session(**session)
    return None

async def create_session(user_id: str, request: Request) -> Session:
    session_id = str(uuid.uuid4())
    session = Session(
        session_id=session_id,
        created_at=int(time.time()),
        expires_at=int(time.time() + 3600 * 6),
        user_id=user_id,
        permissions=["user"],
    )
    if VALKEY_ENABLED:
        await rdb.set(session_id, json.dumps(session.dict()))
    else:
        collection = db["session_ids"]
        collection.insert_one(session.dict())
    response = JSONResponse(status_code=200, content={"response": "Session created"})
    response.set_cookie("session_id", session_id, max_age=31536000, secure=HTTPS_ONLY, httponly=True)
    return session

async def create_developer_session(user_id: str, request: Request) -> Session:
    session_id = str(uuid.uuid4())
    session = Session(
        session_id=session_id,
        created_at=int(time.time()),
        expires_at=int(time.time() + 3600 * 6),
        user_id=user_id,
        permissions=["developer"],
    )
    if VALKEY_ENABLED:
        await rdb.set(session_id, json.dumps(session.dict()))
    else:
        collection = db["session_ids"]
        collection.insert_one(session.dict())
    response = JSONResponse(status_code=200, content={"response": "Session created"})
    response.set_cookie("session_id", session_id, max_age=31536000, secure=HTTPS_ONLY, httponly=True)
    return session

async def delete_session(session_id: str) -> None:
    if VALKEY_ENABLED:
        await rdb.delete(session_id)
    else:
        collection = db["session_ids"]
        collection.delete_one({"session_id": session_id})


async def auth_required(request: Request, call_next):
    session_id = request.cookies.get("session_id")
    if not session_id:
        return JSONResponse(status_code=401, content={"response": "Unauthorized"})

    session = await get_session(session_id)
    if not session:
        return JSONResponse(status_code=401, content={"response": "Unauthorized"})

    expires_at = session.expires_at
    if time.time() > expires_at:
        old_session_id = session.session_id
        session = await create_session(session.user_id, request)
        await delete_session(old_session_id)

    request.state.session_id = session.session_id
    request.state.created_at = session.created_at
    request.state.expires_at = session.expires_at
    request.state.user_id = session.user_id
    request.state.permissions = session.permissions

    return await call_next(request)