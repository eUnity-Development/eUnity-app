from fastapi import FastAPI, HTTPException, Depends
from fastapi.responses import RedirectResponse
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel
from typing import Optional

import os
import asyncio
from bson.objectid import ObjectId
from pymongo import MongoClient

app = FastAPI()

# Load .env file
if os.path.exists(".env"):
    with open(".env", "r") as f:
        for line in f.readlines():
            key, value = line.strip().split("=")
            os.environ[key] = value

# MongoDB connection
client = MongoClient(os.getenv("MONGO_DB_URI"))
db = client["eunity-main"]

# Google OAuth settings
GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
GOOGLE_CLIENT_SECRET = os.getenv("GOOGLE_CLIENT_SECRET")
GOOGLE_REDIRECT_URI = os.getenv("GOOGLE_REDIRECT_URI")

# OAuth2 scheme
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/token")


class User(BaseModel):
    email: str
    first_name: str
    last_name: str
    avatar_url: str
    user_id: str


class Developer(BaseModel):
    id: ObjectId
    email: str
    first_name: str
    last_name: str
    avatar_url: str
    providers: dict


async def get_current_user(token: str = Depends(oauth2_scheme)):
    # Implement token verification and user lookup logic here
    pass


@app.get("/webAuth/google")
async def begin_google_auth():
    # Begin Google auth process
    scopes = ["email", "profile"]
    auth_url = f"https://accounts.google.com/o/oauth2/auth?client_id={GOOGLE_CLIENT_ID}&redirect_uri={GOOGLE_REDIRECT_URI}&scope={'+'.join(scopes)}&response_type=code"
    return RedirectResponse(url=auth_url, status_code=302)


@app.get("/webAuth/google/callback")
async def google_oauth_callback(code: str):
    # Handle Google OAuth callback
    user, err = await complete_user_auth(code)
    if err:
        raise HTTPException(status_code=400, detail="Unable to authenticate")

    email = user.email
    dev = db["whitelisted-devs"].find_one({"email": email})
    if dev is None:
        return {"response": "Account not authorized"}

    developer = db["developers"].find_one({"email": email})
    if developer is None:
        new_dev = Developer(
            email=user.email,
            first_name=user.first_name,
            last_name=user.last_name,
            avatar_url=user.avatar_url,
            providers={
                "google": {
                    "name": user.name,
                    "email": user.email,
                    "email_verified": user.raw_data["verified_email"],
                    "sub": user.user_id,
                }
            },
        )
        db["developers"].insert_one(new_dev)

    developer = db["developers"].find_one({"email": email})
    session_id = await create_developer_session(developer["_id"], " dashboard")
    return RedirectResponse(url="/dashboard", status_code=302)


async def complete_user_auth(code: str):
    # Implement Google OAuth authentication logic here
    pass


async def create_developer_session(dev_id: str, redirect_url: str):
    # Implement session creation logic here
    pass
