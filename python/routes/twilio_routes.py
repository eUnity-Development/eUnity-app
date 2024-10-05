from fastapi import APIRouter
from controllers import twilio_controllers as twilio_controller


# Create an instance of the TwilioController

# Create an instance of the APIRouter with a prefix and tags
router = APIRouter(tags=["Twilio"])


# Define the route for sending a verification SMS
@router.post("/send-sms")
async def send_ver_sms(phone_number : str):
    return await twilio_controller.send_ver_sms(phone_number)


# Define the route for verifying a phone number
@router.post("/verify-phone")
async def verify_phone(phone_number: str, code : str):
    return await twilio_controller.verify_phone(phone_number, code)