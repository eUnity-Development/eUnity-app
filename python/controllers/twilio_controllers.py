from fastapi import Query, HTTPException
from fastapi import APIRouter
from helpers.twilio_manager import TwilioManager


router = APIRouter()

@router.post("/twilio/send-sms")
async def send_ver_sms(to: str = Query(...), body: str = Query(...)):
    try:
        # err = TwilioManager.SendMessage(to, "+17162721672", body)
        _, err = await TwilioManager.send_verification_code(to)
        if err != None:
            raise HTTPException(status_code=500, detail={"error": str(err)})
    except Exception as e:
        raise HTTPException(status_code=500, detail={"error": str(e)})
    return {"message": "SMS sent successfully!"}

@router.post("/twilio/verify-phone")
async def verify_phone(to: str = Query(...), code: str = Query(...)):
    try:
        valid, err = await TwilioManager.verify_code(to, code)
        if err != None:
            raise HTTPException(status_code=500, detail={"error": str(err), "message": "make sure to add +1 to the phone number format --> +1xxxxxxxxxx"})
        if not valid:
            raise HTTPException(status_code=400, detail={"message": "Invalid verification code!"})
    except Exception as e:
        raise HTTPException(status_code=500, detail={"error": str(e)})
    return {"message": "Phone number verified successfully!"}