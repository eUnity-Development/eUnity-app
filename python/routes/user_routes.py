from fastapi import APIRouter, Depends, HTTPException
from fastapi.requests import Request
from controllers import user_controllers
from models.user import User


router = APIRouter(tags=["User"])


@router.get("/me")
async def read_me(request: Request):
    return await user_controllers.get_me(request)

@router.patch("/me")
async def update_me(request: Request, user: dict):
    return await user_controllers.patch_me(request, user)

@router.get("/get_user/{user_id}")
async def read_user(user_id: int):
    return await user_controllers.get_user(user_id)

@router.post("/logout")
async def logout(request: Request):
    return await user_controllers.logout(request=request)
