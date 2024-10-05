from fastapi import APIRouter, Depends
from controllers import dev_controllers


# Create an instance of the DevControllers class

# Create a FastAPI router with a prefix of '/dev'
router = APIRouter(tags=["Development"])


# Define the route for '/dev/force_login'
@router.get("/force_login")
async def force_login(email : str):
    return await dev_controllers.force_login(email=email)


# Define the route for '/dev/generate_mock_users'
@router.get("/generate_mock_users")
async def generate_mock_users(amount: int):
    return await dev_controllers.generate_mock_users(amount=amount)