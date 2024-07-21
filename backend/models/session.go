package models

type Session struct {
	Session_id  string   `json:"session_id" bson:"session_id"`
	Expires_at  int64    `json:"expires_at" bson:"expires_at"`
	Created_at  int64    `json:"created_at" bson:"created_at"`
	User_id     string   `json:"user_id" bson:"user_id"`
	Permissions []string `json:"permissions" bson:"permissions"`
}
