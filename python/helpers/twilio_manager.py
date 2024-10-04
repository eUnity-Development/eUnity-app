from fastapi import FastAPI, Depends
from twilio.rest import Client
from twilio.base.exceptions import TwilioRestException
from pydantic import BaseSettings
import os
import logging
from dotenv import load_dotenv

load_dotenv()

logging.basicConfig(level=logging.INFO)

TWILIO_ACCOUNT_SID = os.getenv("TWILIO_ACCOUNT_SID")
TWILIO_AUTH_TOKEN = os.getenv("TWILIO_AUTH_TOKEN")
TWILIO_SERVICE_SID = os.getenv("TWILIO_SERVICE_SID")



client = Client(
    username=TWILIO_ACCOUNT_SID,
    password=TWILIO_AUTH_TOKEN,
)


class TwilioManager():



    @staticmethod
    async def send_verification_code(to: str):
        try:
            verification = client.verify.v2.services(TWILIO_SERVICE_SID).verifications.create(to=to, channel="sms")
            return {"message": "Verification code sent successfully"}
        except TwilioRestException as e:
            return {"error": str(e)}, 500

    @staticmethod
    async def verify_code(to: str, code: str):
        try:
            verification_check = client.verify.v2.services(TWILIO_SERVICE_SID).verification_checks.create(to=to, code=code)
            return {"valid": verification_check.valid}
        except TwilioRestException as e:
            return {"error": str(e)}, 500