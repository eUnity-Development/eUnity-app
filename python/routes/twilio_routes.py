from fastapi import APIRouter
from controllers import twilio_controllers as twilio_controller


# Create an instance of the TwilioController

# Create an instance of the APIRouter with a prefix and tags
router = APIRouter()


# Define the route for sending a verification SMS
@router.post("/send-sms")
async def send_ver_sms():
    return twilio_controller.send_ver_sms()


# Define the route for verifying a phone number
@router.post("/verify-phone")
async def verify_phone():
    return twilio_controller.verify_phone()