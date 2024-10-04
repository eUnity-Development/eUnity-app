from fastapi import FastAPI
from pydantic import BaseModel, Field
from typing import Optional, List, Dict
from provider import Provider

class Height(BaseModel):
    feet: Optional[int] = Field(description="Height in feet")
    inches: Optional[int] = Field(description="Height in inches")
    centimeters: Optional[int] = Field(description="Height in centimeters")

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
    id: str = Field(regex=r"[a-f0-9]{24}", description="MongoDB ObjectID")
    email: str = Field(description="Email address")
    verified_email: bool = Field(description="Is email verified")
    verified_phone_number: bool = Field(description="Is phone number verified")
    is_profile_set_up: bool = Field(description="Is profile set up")
    phone_number: Optional[str] = Field(description="Phone number")
    gender: Optional[str] = Field(description="Gender")
    location: Optional[str] = Field(description="Location")
    height: Optional[Height] = Field(description="Height")
    date_of_birth: Optional[DateOfBirth] = Field(alias="dob")
    first_name: Optional[str] = Field(description="First name")
    last_name: Optional[str] = Field(description="Last name")
    providers: Dict[str, Provider] = Field(description="Providers")
    media_files: List[str] = Field(description="Media files")
    match_preferences: MatchPreferences = Field(description="Match preferences")
    bio: Optional[str] = Field(description="Bio")


class RestrictedUser(BaseModel):
    id: str = Field(regex=r"[a-f0-9]{24}", description="MongoDB ObjectID")
    gender: Optional[str] = Field(description="Gender")
    location: Optional[str] = Field(description="Location")
    height: Optional[Height] = Field(description="Height")
    date_of_birth: Optional[DateOfBirth] = Field(alias="dob")
    first_name: Optional[str] = Field(description="First name")
    media_files: List[str] = Field(description="Media files")
    bio: Optional[str] = Field(description="Bio")









