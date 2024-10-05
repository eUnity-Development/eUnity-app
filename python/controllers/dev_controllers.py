from fastapi import FastAPI, Query
from fastapi.responses import JSONResponse
from fastapi.requests import Request
from pymongo import MongoClient
from helpers.db_manager import DBManager
from helpers import session_manager
from helpers import mock_users_gen

db = DBManager.db
users_collection = db["users"]


async def force_login(email: str):
    # take in email and force creates a session for that user
    # this is only for development purposes
    print("force_login")

    user = users_collection.find_one({"email": email})
    print(user)

    if user is None:
        return JSONResponse(status_code=400, content={"response": "User not found"})

    # create session
    response = await session_manager.create_session(str(user["_id"]))

    return response


async def generate_mock_users(amount: int):
    # create mock users for development purposes

    user, err = await mock_users_gen.gen_mock_users(amount)
    if err != None:
        return JSONResponse(
            status_code=400, content={"response": "Error creating mock users"}
        )

    # always return a random user email that I am able to login with
    return JSONResponse(
        status_code=200,
        content={
            "response": f"{amount} mock users created",
            "random_user_email": user.__dict__["email"],
        },
    )
