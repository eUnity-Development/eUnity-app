from fastapi import APIRouter, HTTPException
from typing import List
import requests
from datetime import datetime
from pydantic import BaseModel, Field
from bson import ObjectId
from db_manager import DBManager

# get db from db_manager
db = DBManager.db
users_collection = db["users"]

class User(BaseModel):
    id: str = Field(default_factory=lambda: str(ObjectId()))
    email: str
    verified_email: bool
    phone_number: str
    first_name: str
    last_name: str
    gender: str
    location: str
    match_preferences: dict
    date_of_birth: dict
    height: dict
    providers: dict
    media_files: List[str]


class DateOfBirth(BaseModel):
    day: int
    month: int
    year: int


class Height(BaseModel):
    feet: int
    inches: int


class Provider(BaseModel):
    name: str
    email: str
    email_verified: bool
    sub: str


class MatchPreferences(BaseModel):
    genders: List[str]
    relationship_types: List[str]
    minimum_age: int
    maximum_age: int
    maximum_distance: int


async def get_random_user(amount: str):
    url = f"https://randomuser.me/api/?results={amount}"
    response = requests.get(url)
    if response.status_code != 200:
        raise HTTPException(status_code=500, detail="Error fetching users")
    data = response.json()
    users = []
    for user_data in data["results"]:
        dob_string = user_data["dob"]["date"]
        parsed_date = datetime.strptime(dob_string, "%Y-%m-%dT%H:%M:%SZ")
        dob = DateOfBirth(
            day=parsed_date.day,
            month=parsed_date.month,
            year=parsed_date.year,
        )
        user = User(
            email=user_data["email"],
            verified_email=True,
            phone_number=user_data["phone"],
            first_name=user_data["name"]["first"],
            last_name=user_data["name"]["last"],
            gender=user_data["gender"],
            location=user_data["location"]["country"],
            match_preferences=MatchPreferences(
                genders=["Men", "Women"],
                relationship_types=["Long Term Relationships"],
                minimum_age=18,
                maximum_age=39,
                maximum_distance=40,
            ).dict(),
            date_of_birth=dob.dict(),
            height=Height(feet=5, inches=8).dict(),
            providers={"google": Provider(
                name=f"{user_data['name']['first']} {user_data['name']['last']}",
                email=user_data["email"],
                email_verified=True,
                sub="sub",
            ).dict()},
            media_files=[user_data["picture"]["large"]],
        )
        users.append(user)
    return users


async def generate_x_users(amount: str):
    return await get_random_user(amount)


async def insert_mock_users(amount: str):
    users = await generate_x_users(amount)
    for user in users:
        users_collection.insert_one(user.dict())
    return users[0], None


async def gen_mock_users(amount: str):
    user, err = await insert_mock_users(amount)
    if err:
        raise HTTPException(status_code=500, detail="Error inserting mock users")
    return user


@router.post("/gen-mock-users/{amount}")
async def generate_mock_users(amount: str):
    user = await gen_mock_users(amount)
    return user
