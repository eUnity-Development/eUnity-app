package models

type Provider struct {
	Name           string `json:"name"`
	Email          string `json:"email"`
	Email_verified bool   `json:"email_verified"`
	Sub            string `json:"sub"`
}
