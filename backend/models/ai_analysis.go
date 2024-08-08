package models

import "time"

type AI_Analysis struct {
	UserID          string    `bson:"user_id" json:"user_id"`
	BioAnalysis     string    `bson:"bio_analysis" json:"bio_analysis"`
	PhotoAnalysis   string    `bson:"photo_analysis" json:"photo_analysis"`
	OverallAnalysis string    `bson:"overall_analysis" json:"overall_analysis"`
	Timestamp       time.Time `bson:"timestamp" json:"timestamp"`
}
