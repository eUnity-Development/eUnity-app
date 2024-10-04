
import pymongo
import os
from dotenv import load_dotenv

load_dotenv()

class DBManager:
    host = os.getenv("DATABASE_URL")
    client = pymongo.MongoClient(host)
    db = client["eunity"]

