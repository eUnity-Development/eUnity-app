package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type UserReport struct {
	ID             *primitive.ObjectID `bson:"_id" json:"_id"`
	ReportedUser   string              `bson:"reported_user" json:"reported_user" form:"reported_user"`
	ReportedBy     string              `bson:"reported_by" json:"reported_by"`
	RuleViolations []string            `bson:"rule_violations" json:"rule_violations" form:"rule_violations"`
	ReportComments string              `bson:"report_comments" json:"report_comments" form:"report_comments"`
	ReportedAt     time.Time           `json:"reported_at" bson:"reported_at"`
}
