from fastapi import FastAPI, Depends
from fastapi.responses import FileResponse
import os
import uvicorn

from helpers.db_manager import DBManager
from helpers import session_manager as SessionManager

from routes import feedback_routes, auth_routes, user_routes, media_routes, twilio_routes, report_issue_routes, report_user_routes, dev_routes

app = FastAPI(title="Eunity Backend API", version="1.0")


# Set up favicon
@app.get("/favicon.ico")
def favicon():
    return FileResponse("icons/favicon.ico")

# Set up route groups
# pub_media_router = app.api_router.include_router(media_routes.pubRouter, prefix="/media")
# feedback_router = app.api_router.include_router(feedback_routes.router, prefix="/feedback")
# web_auth_router = app.api_router.include_router(auth_routes.router, prefix="/webAuth")
# auth_router = app.api_router.include_router(auth_routes.router, prefix="/auth")

# Protected routes
app.include_router(user_routes.router, prefix="/users", dependencies=[Depends(SessionManager.auth_required)])
app.include_router(twilio_routes.router, prefix="/twilio")
app.include_router(media_routes.router, prefix="/media", dependencies=[Depends(SessionManager.auth_required)])

app.include_router(report_issue_routes.router, prefix="/report_issue", dependencies=[Depends(SessionManager.auth_required)])
app.include_router(report_user_routes.router, prefix="/report_user", dependencies=[Depends(SessionManager.auth_required)])

# Development only routes
app.include_router(dev_routes.router, prefix="/dev")






if __name__ == "__main__":
    uvicorn.run(app)
    print("Shutting down server...")
