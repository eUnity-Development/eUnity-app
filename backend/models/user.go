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
	DateOfBirth           *DateOfBirth        `bson:"dob" json:"dob,omitempty"`
	FirstName             string              `bson:"first_name" json:"first_name,omitempty"`
	LastName              string              `bson:"last_name" json:"last_name,omitempty"`
	Providers             map[string]Provider `bson:"providers" json:"providers,omitempty"`
	MediaFiles            []string            `bson:"media_files" json:"media_files"`
	MatchPreferences      MatchPreferences    `bson:"match_preferences" json:"match_preferences,omitempty"`
	Bio                   string              `bson:"bio" json:"bio,omitempty"`
	About                 About               `bson:"about" json:"about"`
	Lifestyle             Lifestyle           `bson:"lifestyle" json:"lifestyle"`
}

type RestrictedUser struct {
	ID          *primitive.ObjectID `bson:"_id" json:"_id,omitempty"`
	Gender      string              `bson:"gender" json:"gender,omitempty"`
	Location    string              `bson:"location" json:"location,omitempty"`
	DateOfBirth *DateOfBirth        `bson:"dob" json:"dob,omitempty"`
	FirstName   string              `bson:"first_name" json:"first_name,omitempty"`
	MediaFiles  []string            `bson:"media_files" json:"media_files"`
	Bio         string              `bson:"bio" json:"bio,omitempty"`
	About       *About              `bson:"about" json:"about"`
	Lifestyle   *Lifestyle          `bson:"lifestyle" json:"lifestyle"`
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

type About struct {
	Pronouns  string   `bson:"pronouns" json:"pronouns"`
	Education string   `bson:"education" json:"education"`
	Job       string   `bson:"job" json:"job"`
	Interests []string `bson:"interests" json:"interests"`
	Ethnicity []string `bson:"ethnicity" json:"ethnicity"`
	Politics  string   `bson:"politics" json:"politics"`
	Religion  []string `bson:"religion" json:"religion"`
	City      string   `bson:"city" json:"city"`
	Height    Height   `bson:"height" json:"height"`
}

type Lifestyle struct {
	Exercise    string   `bson:"exercise" json:"exercise"`
	Drinking    string   `bson:"drinking" json:"drinking"`
	Cannabis    string   `bson:"cannabis" json:"cannabis"`
	SocialMedia string   `bson:"social_media" json:"social_media"`
	Pets        string   `bson:"pets" json:"pets"`
	Diet        []string `bson:"diet" json:"diet"`
}

func FromGooglePayload(payload *idtoken.Payload) *User {
	objectID := primitive.NewObjectID()
	match_preferences := &MatchPreferences{
		Genders:           []string{},
		RelationshipTypes: []string{},
		MinimumAge:        18,
		MaximumAge:        40,
		MaximumDistance:   20,
	}
	height := &Height{
		Feet:        0,
		Inches:      0,
		Centimeters: 0,
	}
	about := &About{
		Pronouns:  "",
		Education: "",
		Job:       "",
		Interests: []string{},
		Ethnicity: []string{},
		Politics:  "",
		Religion:  []string{},
		City:      "",
		Height:    *height,
	}
	lifestyle := &Lifestyle{
		Exercise:    "",
		Drinking:    "",
		Cannabis:    "",
		SocialMedia: "",
		Pets:        "",
		Diet:        []string{},
	}
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
		MediaFiles:       []string{},
		MatchPreferences: *match_preferences,
		About:            *about,
		Lifestyle:        *lifestyle,
	}

	return user
}
