from fastapi import APIRouter, Depends, HTTPException
from fastapi.requests import Request
from controllers import user_controllers
from fastapi import Cookie
from typing import Optional


router = APIRouter(tags=["User"])


@router.get("/me")
async def read_me(request: Request):
    return user_controllers.get_me(request)

@router.patch("/me")
async def update_me(user: dict):
    return user_controllers.patch_me(user)

@router.get("/get_user/{user_id}")
async def read_user(user_id: int):
    return user_controllers.get_user(user_id)

@router.post("/logout")
async def logout(user: dict):
    return user_controllers.post_logout(user)

@router.get("/Testing_Context")
async def testing_context(user: dict):
    return user_controllers.testing_context(user)