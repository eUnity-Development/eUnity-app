from pydantic import BaseModel
from typing import Optional, Dict
from provider import Provider
from bson import ObjectId
from pydantic import field_validator, Field
from typing import Any
from datetime import datetime


class Developer(BaseModel):
    id: ObjectId = Field(
        default_factory=ObjectId, alias="_id", description="MongoDB ObjectID"
    )
    email: str
    first_name: str
    last_name: str
    avatar_url: Optional[str] = None
    providers: Dict[str, Provider]

    class Config:
        arbitrary_types_allowed = True  # Allow custom types

    # You can add validators as needed, here’s an example:
    @field_validator("email")
    def validate_email(cls, value):
        if not value.strip():
            raise ValueError("Email cannot be empty")
        return value

    @field_validator("id")
    def validate_id(cls, value):
        if not isinstance(value, ObjectId):
            raise ValueError("Invalid ObjectId")
        return value

    @field_validator("id")
    def validate_id(cls, v):
        if not isinstance(v, ObjectId):
            raise ValueError("Invalid ObjectId")
        return v

    # Custom dict method to handle _id
    def dict(self):
        data = self.model_dump(by_alias=True)  # Use by_alias to get the alias names
        return data

    def to_json(self) -> dict:
        """Convert BSON object to a JSON-serializable dictionary."""
        bson_obj = (
            self.dict()
        )  # Assuming self.dict() returns a dictionary representation of the object
        if isinstance(bson_obj, ObjectId):
            return str(bson_obj)  # Convert ObjectId to string
        elif isinstance(bson_obj, dict):
            return {
                key: self._convert_value_to_json(value)
                for key, value in bson_obj.items()
            }
        elif isinstance(bson_obj, list):
            return [self._convert_value_to_json(item) for item in bson_obj]
        else:
            return bson_obj

    def _convert_value_to_json(self, value):
        """Helper method to convert values to JSON-serializable format."""
        if isinstance(value, ObjectId):
            return str(value)  # Convert ObjectId to string
        elif isinstance(value, datetime):
            return value.isoformat()  # Convert datetime to ISO 8601 string
        elif isinstance(value, dict):
            return {key: self._convert_value_to_json(val) for key, val in value.items()}
        elif isinstance(value, list):
            return [self._convert_value_to_json(item) for item in value]
        else:
            return value

    class Config:
        arbitrary_types_allowed = True
