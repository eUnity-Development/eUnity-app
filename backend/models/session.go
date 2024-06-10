package models

type Session struct {
	Session_id  string   `json:"session_id"`
	Expires_at  string   `json:"expires_at"`
	Created_at  string   `json:"created_at"`
	User_id     string   `json:"user_id"`
	Permissions []string `json:"permissions"`
}
