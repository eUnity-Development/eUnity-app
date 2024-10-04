from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import JSONResponse
from fastapi.requests import Request
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel
from helpers.db_manager import DBManager
import bson
from models.user import User, RestrictedUser
from helpers.session_manager import SessionManager


# Initialize the router for the controller
router = APIRouter()
db = DBManager.db


@router.get("/users/me")
async def get_me(user_id: str):
    # turn string id into bson object id
    bson_user_id = bson.ObjectId(user_id)
    user = await db["users"].find_one({"_id": bson_user_id})
    if user is None:
        raise HTTPException(status_code=400, detail="No user found")
    return user

@router.patch("/users/me")
async def patch_me(user: User, user_id: str):
    # get user id
    bson_user_id = bson.ObjectId(user_id)
    # get values and types from user object
    v = user.__dict__
    for key, value in v.items():
        if key == "_id" or key == "email":
            continue
        if value is None:
            continue
        update_filter = {"$set": {key: value}}
        result = await db["users"].update_one({"_id": bson_user_id}, update_filter)
        if result.modified_count == 0:
            raise HTTPException(status_code=400, detail="Unable to update user")
    return JSONResponse(status_code=200, content={"response": "User updated"})

@router.get("/users/get_user/{user_id}")
async def get_user(user_id: str):
    # turn string id into bson object id
    bson_user_id = bson.ObjectId(user_id)
    user = await db["users"].find_one({"_id": bson_user_id})
    if user is None:
        raise HTTPException(status_code=400, detail="No user found")
    return RestrictedUser(**user)

@router.post("/users/logout")
async def logout(request: Request):
    # remove session
    await db["session_ids"].delete_one({"session_id": session_id})
    # remove cookies
    response = JSONResponse(status_code=200, content={"response": "Logged out"})
    response.set_cookie("session_id", "", expires=-1, domain=SessionManager.Cookie_Host, secure=SessionManager.HTTPS_only)
    return response

@router.get("/users/Testing_Context")
async def testing_context(request: Request):
    session_id = request.cookies.get("session_id")
    user_id = user_id
    expires_at = request.cookies.get("expires_at")
    created_at = request.cookies.get("created_at")
    permissions = request.cookies.get("permissions")
    return JSONResponse(status_code=200, content={"session_id": session_id, "user_id": user_id, "expires_at": expires_at, "created_at": created_at, "permissions": permissions})
