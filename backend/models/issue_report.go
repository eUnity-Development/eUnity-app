package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type IssueReport struct {
	ID               *primitive.ObjectID `bson:"_id" json:"_id"`
	User_ID          string              `bson:"user_id" json:"user_id"`
	IssueDescription string              `bson:"description" json:"description" form:"description"`
	Contact_Email    string              `bson:"email" json:"email" form:"email"`
	MediaFiles       []string            `bson:"media_files" json:"media_files" form:"media_files"`
	Submitted        bool                `bson:"submitted" json:"submitted"`
	Updated_At       time.Time           `json:"updated_at" bson:"updated_at"`
}
