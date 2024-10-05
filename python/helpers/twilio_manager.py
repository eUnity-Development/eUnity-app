from fastapi import FastAPI, Depends
from twilio.rest import Client
from twilio.base.exceptions import TwilioRestException
import os
import logging
from dotenv import load_dotenv

load_dotenv()

logging.basicConfig(level=logging.INFO)


###get values from eunityusa.com/dashboard
TWILIO_KEY_SID = os.getenv("TWILIO_KEY_SID")
TWILIO_KEY_SECRET = os.getenv("TWILIO_KEY_SECRET")
TWILIO_SERVICE_SID = os.getenv("TWILIO_SERVICE_SID")



client = Client(
    username=TWILIO_KEY_SID,
    password=TWILIO_KEY_SECRET,
)


class TwilioManager():



    @staticmethod
    async def send_verification_code(to: str):
        try:
            print(TWILIO_SERVICE_SID)

            verification = client.verify.v2.services(TWILIO_SERVICE_SID).verifications.create(to=to, channel="sms")
            ##check there was no error
            logging.info(verification)
            return {"message": "Verification code sent successfully"}, None
        except TwilioRestException as e:
            return {"error": str(e)}, e.code

    @staticmethod
    async def verify_code(to: str, code: str):
        try:
            verification_check = client.verify.v2.services(TWILIO_SERVICE_SID).verification_checks.create(to=to, code=code)
            return {"valid": verification_check.valid}, None
        except TwilioRestException as e:
            return {"error": str(e)}, e.code