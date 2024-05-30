package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type User struct {
	ID                *primitive.ObjectID `bson:"_id" json:"_id,omitempty"`
	Password          string              `bson:"-" json:"-" form:"password"  validate:"required,min=8,max=100"`
	Email             string              `bson:"email" json:"email,omitempty" form:"email" validate:"required,email"`
	PasswordHash      string              `bson:"passwordHash" json:"-"`
	Verified          bool                `bson:"verified" json:"verified,omitempty"`
	PhoneNumber       string              `bson:"phone_number" json:"phone_number,omitempty"`
	Gender            string              `bson:"gender" json:"gender,omitempty"`
	Location          string              `bson:"location" json:"location,omitempty"`
	Height            *Height             `bson:"height" json:"height,omitempty"`
	RelationshipTypes []string            `bson:"relationship_types" json:"relationship_types,omitempty"`
	DateOfBirth       *DateOfBirth        `bson:"dob" json:"dob,omitempty"`
	FirstName         string              `bson:"first_name" json:"first_name,omitempty"`
	LastName          string              `bson:"last_name" json:"last_name,omitempty"`
	MediaFiles        []string            `bson:"media_files" json:"media_files,omitempty"`
}

type DateOfBirth struct {
	Day   int `json:"day,omitempty"`
	Month int `json:"month,omitempty"`
	Year  int `json:"year,omitempty"`
}

type Height struct {
	Feet        int `json:"feet,omitempty"`
	Inches      int `json:"inches,omitempty"`
	Centimeters int `json:"centimeters,omitempty"`
}
