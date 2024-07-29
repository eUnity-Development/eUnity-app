package models

import "time"

type Feedback struct {
	User          string `form:"user" json:"user" bson:"user"`
	Stars         int    `form:"stars" json:"stars" bson:"stars"`
	Positive_text string `form:"positive_message" json:"positive_message" bson:"positive_message"`
	Negative_text string `form:"negative_message" json:"negative_message" bson:"negative_message"`
	Submitted_at  time.Time `json:"submitted_at" bson:"submitted_at"`
}
