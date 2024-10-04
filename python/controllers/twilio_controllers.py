from fastapi import FastAPI, Query, HTTPException
from helpers.twilio_manager import TwilioManager



class TwilioControllers:
    def __init__(self):
        pass

@app.post("/twilio/send-sms")
async def send_ver_sms(to: str = Query(...), body: str = Query(...)):
    print("to:", to)
    print("body:", body)
    try:
        # err = TwilioManager.SendMessage(to, "+17162721672", body)
        err = TwilioManager.Send_Verification_Code(to)
        if err:
            raise HTTPException(status_code=500, detail={"error": str(err)})
    except Exception as e:
        raise HTTPException(status_code=500, detail={"error": str(e)})
    return {"message": "SMS sent successfully!"}

@app.post("/twilio/verify-phone")
async def verify_phone(to: str = Query(...), code: str = Query(...)):
    print("to:", to)
    print("code:", code)
    try:
        valid, err = TwilioManager.Verify_Code(to, code)
        if err:
            raise HTTPException(status_code=500, detail={"error": str(err), "message": "make sure to add +1 to the phone number format --> +1xxxxxxxxxx"})
        if not valid:
            raise HTTPException(status_code=400, detail={"message": "Invalid verification code!"})
    except Exception as e:
        raise HTTPException(status_code=500, detail={"error": str(e)})
    return {"message": "Phone number verified successfully!"}