package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/api/idtoken"
)

type User struct {
	ID                    *primitive.ObjectID `bson:"_id" json:"_id,omitempty"`
	Email                 string              `bson:"email" json:"email,omitempty" form:"email" validate:"required,email"`
	Verified_email        bool                `bson:"verified_email" json:"verified_email,omitempty"`
	Verified_phone_number bool                `bson:"verified_phone_number" json:"verified_phone_number,omitempty"`
	IsProfileSetUp        bool                `bson:"is_profile_set_up" json:"is_profile_set_up"`
	PhoneNumber           string              `bson:"phone_number" json:"phone_number,omitempty"`
	Gender                string              `bson:"gender" json:"gender,omitempty"`
	Location              string              `bson:"location" json:"location,omitempty"`
	Height                *Height             `bson:"height" json:"height,omitempty"`
	DateOfBirth           *DateOfBirth        `bson:"dob" json:"dob,omitempty"`
	FirstName             string              `bson:"first_name" json:"first_name,omitempty"`
	LastName              string              `bson:"last_name" json:"last_name,omitempty"`
	Providers             map[string]Provider `bson:"providers" json:"providers,omitempty"`
	MediaFiles            []string            `bson:"media_files" json:"media_files,omitempty"`
	MatchPreferences      MatchPreferences    `bson:"match_preferences" json:"match_preferences,omitempty"`
	Bio                   string              `bson:"bio" json:"bio,omitempty"`
}

type RestrictedUser struct {
	ID          *primitive.ObjectID `bson:"_id" json:"_id,omitempty"`
	Gender      string              `bson:"gender" json:"gender,omitempty"`
	Location    string              `bson:"location" json:"location,omitempty"`
	Height      *Height             `bson:"height" json:"height,omitempty"`
	DateOfBirth *DateOfBirth        `bson:"dob" json:"dob,omitempty"`
	FirstName   string              `bson:"first_name" json:"first_name,omitempty"`
	MediaFiles  []string            `bson:"media_files" json:"media_files,omitempty"`
	Bio         string              `bson:"bio" json:"bio,omitempty"`
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

type MatchPreferences struct {
	Genders           []string `bson:"genders" json:"genders"`
	RelationshipTypes []string `bson:"relationship_types" json:"relationship_types"`
	MinimumAge        int      `bson:"minimum_age" json:"minimum_age"`
	MaximumAge        int      `bson:"maximum_age" json:"maximum_age"`
	MaximumDistance   int      `bson:"maximum_distance" json:"maximum_distance"`
}

func FromGooglePayload(payload *idtoken.Payload) *User {
	objectID := primitive.NewObjectID()
	user := &User{
		ID:             &objectID,
		Email:          payload.Claims["email"].(string),
		FirstName:      payload.Claims["given_name"].(string),
		LastName:       payload.Claims["family_name"].(string),
		Verified_email: payload.Claims["email_verified"].(bool),
		Providers: map[string]Provider{
			"google": {
				Name:           payload.Claims["name"].(string),
				Email:          payload.Claims["email"].(string),
				Email_verified: payload.Claims["email_verified"].(bool),
				Sub:            payload.Claims["sub"].(string),
			},
		},
	}

	return user
}
