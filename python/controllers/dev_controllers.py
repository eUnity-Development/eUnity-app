from fastapi import FastAPI, Query
from fastapi.responses import JSONResponse
from fastapi.requests import Request
from pymongo import MongoClient

app = FastAPI()

client = MongoClient("mongodb://localhost:27017/")
db = client["mydatabase"]
users_collection = db["users"]

class DevControllers:
    def __init__(self):
        pass

@app.get("/dev/force_login")
async def force_login(email: str = Query(...)):
    # take in email and force creates a session for that user
    # this is only for development purposes

    user = users_collection.find_one({"email": email})
    if user is None:
        return JSONResponse(status_code=400, content={"response": "User not found"})

    # create session
    session_manager = SessionManager()  # assume this is defined elsewhere
    session_id, err = session_manager.create_session(user["_id"])
    if err:
        return JSONResponse(status_code=400, content={"response": "Unable to create session"})

    return JSONResponse(status_code=200, content={"response": "Session created, user logged in"})

@app.get("/dev/generate_mock_users")
async def generate_mock_users(amount: int = Query(...)):
    # create mock users for development purposes

    mock_users_gen = MockUsersGen()  # assume this is defined elsewhere
    user, err = mock_users_gen.gen_mock_users(amount)
    if err:
        return JSONResponse(status_code=400, content={"response": f"Unable to create mock users: {err}"})

    # always return a random user email that I am able to login with
    return JSONResponse(status_code=200, content={"response": f"{amount} mock users created", "random_user_email": user["email"]})

# assume these are defined elsewhere
class SessionManager:
    def create_session(self, user_id: str) -> (str, str):
        # implement session creation logic here
        pass

class MockUsersGen:
    def gen_mock_users(self, amount: int) -> (dict, str):
        # implement mock user generation logic here
        pass
