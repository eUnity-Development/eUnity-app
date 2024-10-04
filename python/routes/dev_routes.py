from fastapi import APIRouter, Depends
from controllers.dev_controllers import DevControllers


# Create an instance of the DevControllers class
dev_controllers = DevControllers()

# Create a FastAPI router with a prefix of '/dev'
router = APIRouter(prefix="/dev", dependencies=[Depends()])


# Define the route for '/dev/force_login'
@router.get("/force_login")
async def force_login():
    return dev_controllers.Force_Login()


# Define the route for '/dev/generate_mock_users'
@router.get("/generate_mock_users")
async def generate_mock_users():
    return dev_controllers.Generate_Mock_Users()