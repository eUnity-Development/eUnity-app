from fastapi import FastAPI, Depends
from fastapi.responses import RedirectResponse
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import os
import uvicorn



from helpers.db_manager import DBManager
from helpers.session_manager import SessionManager

from routes import feedback_routes, auth_routes, user_routes, media_routes, twilio_routes, report_issue_routes, report_user_routes, messaging_routes, dev_routes

app = FastAPI(title="Eunity Backend API", version="1.0")

# Load environment variables
base_path = os.getenv("BASE_PATH")
swagger_base_path = os.getenv("SWAGGER_BASE_PATH")
port = os.getenv("PORT")

# Set up favicon
@app.get("/favicon.ico")
def favicon():
    return FileResponse("icons/favicon.ico")

# Set up route groups
pub_media_router = app.api_router.include_router(media_routes.pubRouter, prefix="/media")
feedback_router = app.api_router.include_router(feedback_routes.router, prefix="/feedback")
web_auth_router = app.api_router.include_router(auth_routes.router, prefix="/webAuth")
auth_router = app.api_router.include_router(auth_routes.router, prefix="/auth")

# Protected routes
app.api_router.include_router(user_routes.router, prefix="/users", dependencies=[Depends(SessionManager.auth_required)])
app.api_router.include_router(media_routes.router, prefix="/media", dependencies=[Depends(SessionManager.auth_required)])
app.api_router.include_router(twilio_routes.router, prefix="/twilio")
app.api_router.include_router(report_issue_routes.router, prefix="/report_issue", dependencies=[Depends(SessionManager.auth_required)])
app.api_router.include_router(report_user_routes.router, prefix="/report_user", dependencies=[Depends(SessionManager.auth_required)])
app.api_router.include_router(messaging_routes.router, prefix="/messaging", dependencies=[Depends(SessionManager.auth_required)])

# Development only routes
dev_router = app.api_router.include_router(dev_routes.router, prefix="/dev")





if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=int(port))
    print("Shutting down server...")
