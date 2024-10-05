from fastapi import FastAPI, Request, Response
from fastapi.responses import JSONResponse
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel
from bson import ObjectId
from pymongo import MongoClient
from google.auth.transport.requests import Request
from google.oauth2 import id_token
import os
from helpers.db_manager import DBManager

app = FastAPI()

client_id = os.environ.get("GOOGLE_CLIENT_ID")

db = DBManager.db
users_collection = db["users"]
sessions_collection = db["session_ids"]


class SessionManager:
    def create_session(user_id, request):
        # implement session creation logic
        pass


def verify_token(token: str):
    try:
        payload = id_token.verify_oauth2_token(token, Request(), client_id)
        return payload
    except ValueError as e:
        return JSONResponse(status_code=400, content={"error": str(e)})


@app.post("/auth/google")
async def google_auth(request: Request):
    id_token = request.query_params.get("idToken")
    if not id_token:
        return JSONResponse(status_code=400, content={"error": "idToken is required"})

    payload, err = verify_token(id_token)
    if err:
        return JSONResponse(status_code=400, content={"error": str(err)})

    email = payload["email"]
    user = users_collection.find_one({"email": email})

    if user:
        # check if user is already logged in
        session_id = request.cookies.get("session_id")
        if session_id:
            session = sessions_collection.find_one({session_id: {"$exists": True}})
            if session:
                return JSONResponse(
                    status_code=400, content={"response": "Already logged in"}
                )

        # update user provider
        userproviders = user.get("providers", {})
        if "google" not in userproviders:
            userproviders["google"] = Provider(
                name=payload["name"],
                email=payload["email"],
                email_verified=payload["email_verified"],
                sub=payload["sub"],
            )
            users_collection.update_one({"email": email}, {"$set": userproviders})

        # create session
        SessionManager.create_session(user["_id"], request)
        return JSONResponse(status_code=200, content={"response": "Login Successful"})
    else:
        # create new user
        new_user = User(
            email=payload["email"],
            verified_email=payload["email_verified"],
            providers={"google": Provider(**payload)},
        )
        users_collection.insert_one(new_user.dict())
        SessionManager.create_session(new_user.id, request)
        return JSONResponse(
            status_code=200, content={"response": "Google Auth Started"}
        )
