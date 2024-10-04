
from fastapi import APIRouter


router = APIRouter()

# Web Auth Routes
@router.get('/google')
def get_begin_google_auth():
    pass

@router.get('/google/callback')
def get_google_oauth_callback():
    pass

# Auth Routes

@router.post('/google')
def post_google_auth():
    pass

