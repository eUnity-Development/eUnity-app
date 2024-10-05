from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime
from bson import ObjectId
from typing import List
from pydantic import field_validator, Field
from typing import Any


class UserReport(BaseModel):
    id: ObjectId = Field(
        default_factory=ObjectId, alias="_id", description="MongoDB ObjectID"
    )
    reported_user: str
    reported_by: str
    rule_violations: List[str]  # List of rule violations
    report_comments: str
    reported_at: datetime

    class Config:
        arbitrary_types_allowed = True  # Allow ObjectId type

    # Optional: Add validators if necessary
    @field_validator("report_comments")
    def validate_comments(cls, value):
        if not value.strip():
            raise ValueError("Report comments cannot be empty")
        return value

    @field_validator("rule_violations", mode="before")
    def validate_rule_violations(cls, value):
        if not value:
            raise ValueError("At least one rule violation must be reported")
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
