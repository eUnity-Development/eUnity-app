package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Developer struct {
	ID        *primitive.ObjectID `bson:"_id" json:"_id,omitempty"`
	Email     string              `bson:"email" json:"email,omitempty" form:"email" validate:"required,email"`
	FirstName string              `bson:"firstname" json:"firstname,omitempty"`
	LastName  string              `bson:"lastname" json:"lastname,omitempty"`
	AvatarURL string              `bson:"photo_url" json:"photo_url,omitempty"`
	Providers map[string]Provider `bson:"providers" json:"providers,omitempty"`
}
