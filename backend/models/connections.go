package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Connection struct {
	ID          *primitive.ObjectID `bson:"_id" json:"_id,omitempty"`
	UserID      *primitive.ObjectID `bson:"user_id" json:"user_id,omitempty"`
	ThirdPartyIDs map[string]string `bson:"third_party_ids" json:"third_party_ids,omitempty"`
}
