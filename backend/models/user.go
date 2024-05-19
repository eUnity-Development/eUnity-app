package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type User struct {
	ID           *primitive.ObjectID `bson:"_id,omitempty" json:"_id,omitempty"`
	Password     string              `bson:"password,omitempty" json:"-" form:"password" binding:"required" validate:"required,min=8,max=100"`
	Email        string              `bson:"email" json:"email" form:"email" binding:"required" validate:"required,email"`
	PasswordHash string              `bson:"passwordHash" json:"-"`
	Verified     bool                `bson:"verified"`
}
