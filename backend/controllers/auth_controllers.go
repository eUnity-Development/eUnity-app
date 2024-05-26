package controllers

import (
	"fmt"
	"net/http"
	"os" // to access .env file
	"time"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv" // to load .env file
	"github.com/markbates/goth"
	"github.com/markbates/goth/gothic"
	"github.com/markbates/goth/providers/google"
	//"go.mongodb.org/mongo-driver/bson"
	//"go.mongodb.org/mongo-driver/bson/primitive"
)

type Auth_controllers struct{}

// google env variables
var GoogleClientID string
var GoogleClientSecret string
var GoogleRedirectURI string

//var r = gin.Default()

func init() {
	godotenv.Load() //loads the .env file
	goth.UseProviders(

		google.New(os.Getenv("GOOGLE_KEY"), os.Getenv("GOOGLE_SECRET"), "http://localhost:3200/api/v1/users/auth/google/callback", "email", "profile"),

	)
}

func (ac *Auth_controllers) BeginGoogleAuth(c *gin.Context) {
	q := c.Request.URL.Query()
	q.Add("provider", "google")
	c.Request.URL.RawQuery = q.Encode()
	gothic.BeginAuthHandler(c.Writer, c.Request)
}

func (ac *Auth_controllers) OAuthCallback(c *gin.Context) { //#TODO finish this garbo code @AggressiveGas - by @AggressiveGas
	q := c.Request.URL.Query()
	q.Add("provider", "google")
	c.Request.URL.RawQuery = q.Encode()
	user, err := gothic.CompleteUserAuth(c.Writer, c.Request)
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
		return
	}

	//@TODO make the cookie here
	cookie := generate_secure_cookie_third_party(user)
	fmt.Println(cookie)

	//fmt.Println(user.UserID)
	//fmt.Println(user.Provider)

	

}

// generating a secure cookie for third party signup
// - this can be reused for other third party signups
func generate_secure_cookie_third_party(gothUser goth.User) gin.H {
	now := time.Now()
	expires := now.Add(time.Minute * 30) // expires in 30 minutes

	expires_string := expires.Format(time.RFC1123)

	cookie := gin.H{
		"provider":       gothUser.Provider,
		"third_party_id": gothUser.UserID,
		"expires_at":     expires_string,
	}

	return cookie
}


