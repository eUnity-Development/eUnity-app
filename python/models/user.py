from fastapi import FastAPI
from pydantic import BaseModel, Field, field_validator
from typing import Optional, List, Dict
from models.provider import Provider
from bson import ObjectId
from typing import Any
from datetime import datetime




class Height(BaseModel):
    feet: Optional[int] = Field(default=None, description="Height in feet")
    inches: Optional[int] = Field(default=None, description="Height in inches")
    centimeters: Optional[int] = Field(default=None, description="Height in centimeters")

class DateOfBirth(BaseModel):
    day: Optional[int] = Field(description="Day of birth")
    month: Optional[int] = Field(description="Month of birth")
    year: Optional[int] = Field(description="Year of birth")


class MatchPreferences(BaseModel):
    genders: List[str] = Field(description="Preferred genders")
    relationship_types: List[str] = Field(description="Preferred relationship types")
    minimum_age: int = Field(description="Minimum age preference")
    maximum_age: int = Field(description="Maximum age preference")
    maximum_distance: int = Field(description="Maximum distance preference")

class User(BaseModel):
    id: ObjectId = Field(default_factory=ObjectId, alias="_id", description="MongoDB ObjectID")
    email: str = Field(description="Email address")
    verified_email: bool = Field(description="Is email verified")
    verified_phone_number: bool = Field(default=False, description="Is phone number verified")
    is_profile_set_up: bool = Field(default=False, description="Is profile set up")
    phone_number: Optional[str] = Field(default=None, description="Phone number")
    gender: Optional[str] = Field(default=None, description="Gender")
    location: Optional[str] = Field(default=None, description="Location")
    height: Optional['Height'] = Field(default=None, description="Height")
    date_of_birth: Optional['DateOfBirth'] = Field(default=None, alias="dob")
    first_name: Optional[str] = Field(default=None, description="First name")
    last_name: Optional[str] = Field(default=None, description="Last name")
    providers: Dict[str, 'Provider'] = Field(default={}, description="Providers")
    media_files: List[str] = Field(default=[], description="Media files")
    match_preferences: 'MatchPreferences' = Field(description="Match preferences")
    bio: Optional[str] = Field(default=None, description="Bio")

    # Validator to ensure the ObjectId is valid
    @field_validator('id')
    def validate_id(cls, v):
        if not isinstance(v, ObjectId):
            raise ValueError("Invalid ObjectId")
        return v

    # Custom dict method to handle _id
    def dict(self):
        data = self.model_dump(by_alias=True)  # Use by_alias to get the alias names
        return data
    
    class Config:
        arbitrary_types_allowed = True

    def to_json(self) -> dict:
        """Convert BSON object to a JSON-serializable dictionary."""
        bson_obj = self.dict()  # Assuming self.dict() returns a dictionary representation of the object
        if isinstance(bson_obj, ObjectId):
            return str(bson_obj)  # Convert ObjectId to string
        elif isinstance(bson_obj, dict):
            return {key: self._convert_value_to_json(value) for key, value in bson_obj.items()}
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

class RestrictedUser(BaseModel):
    id: ObjectId = Field(default_factory=ObjectId, alias="_id", description="MongoDB ObjectID") ## Changed from regex to pattern
    gender: Optional[str] = Field(description="Gender")
    location: Optional[str] = Field(description="Location")
    height: Optional[Height] = Field(description="Height")
    date_of_birth: Optional[DateOfBirth] = Field(alias="dob")
    first_name: Optional[str] = Field(description="First name")
    media_files: List[str] = Field(description="Media files")
    bio: Optional[str] = Field(description="Bio")

    # Validator to ensure the ObjectId is valid
    @field_validator('id')
    def validate_id(cls, v):
        if not isinstance(v, ObjectId):
            raise ValueError("Invalid ObjectId")
        return v

    # Custom dict method to handle _id
    def dict(self):
        data = self.model_dump(by_alias=True)  # Use by_alias to get the alias names
        return data
    
    class Config:
        arbitrary_types_allowed = True










