package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Swipe struct {
	ID            *primitive.ObjectID `bson:"_id" json:"_id"`
	SwipedUser    string              `bson:"swiped_user" json:"swiped_user" form:"swiped_user"`
	SwipedBy      string              `bson:"swiped_by" json:"swiped_by"`
	CreatedAt     time.Time           `bson:"created_at,omitempty"` // When the document was created
	IsSwipedRight bool                `bson:"swiped_direction" json:"swiped_direction" form:"swiped_direction"`
}
