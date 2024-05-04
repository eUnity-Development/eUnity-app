package models

type User struct {
	ID           string `bson:"_id,omitempty" json:"_id,omitempty"`
	Password     string `bson:"password,omitempty" form:"password" binding:"required" validate:"required,min=8,max=100"`
	Email        string `bson:"email" json:"email" form:"email" binding:"required" validate:"required,email"`
	PasswordHash string `bson:"passwordHash"`
	Verified     bool   `bson:"verified"`
}
