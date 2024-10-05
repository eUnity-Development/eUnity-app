from fastapi import APIRouter, HTTPException
from fastapi.responses import JSONResponse
from fastapi.requests import Request
from helpers.db_manager import DBManager
import bson
from models.user import User, RestrictedUser
from helpers import session_manager as SessionManager
from bson import ObjectId
from typing import Any




# Initialize the router for the controller
router = APIRouter()
db = DBManager.db


@router.get("/users/me")
async def get_me(request: Request):
    #catch error in case user_id is not in state
    if not hasattr(request.state, 'user_id'):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id

    bson_user_id = bson.ObjectId(user_id)
    user = db["users"].find_one({"_id": bson_user_id})
    user = User(**user)
    if user is None:
        raise HTTPException(status_code=400, detail="No user found")
    return JSONResponse(status_code=200, content=user.to_json())

@router.patch("/users/me")
async def patch_me(request: Request, user: dict):
    if not hasattr(request.state, 'user_id'):
        raise HTTPException(status_code=400, detail="No user found")
    user_id = request.state.user_id
    # get user id
    bson_user_id = bson.ObjectId(user_id)
    # get values and types from user object
    for key, value in user.items():
        if key == "_id" or key == "email":
            continue
        if value is None:
            continue
        update_filter = {"$set": {key: value}}
        result = db["users"].update_one({"_id": bson_user_id}, update_filter)
        if result.modified_count == 0:
            raise HTTPException(status_code=400, detail="Unable to update user")
    return JSONResponse(status_code=200, content={"response": "User updated"})

@router.get("/users/get_user/{user_id}")
async def get_user(request : Request):
    # turn string id into bson object id
    user_id = request.cookies.get("user_id")

    bson_user_id = bson.ObjectId(user_id)
    user = await db["users"].find_one({"_id": bson_user_id})
    if user is None:
        raise HTTPException(status_code=400, detail="No user found")
    return RestrictedUser(**user)

@router.post("/users/logout")
async def logout(request: Request):
    # remove session
    session_id = request.cookies.get("session_id")

    db["session_ids"].delete_one({"session_id": session_id})
    # remove cookies
    response = JSONResponse(status_code=200, content={"response": "Logged out"})
    response.set_cookie("session_id", "", expires=-1, domain=SessionManager.COOKIE_HOST, secure=SessionManager.HTTPS_ONLY)
    return response

