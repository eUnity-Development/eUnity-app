package controllers

import (
	//"fmt" // for debugging 
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

// required google env variables
var GoogleClientID string
var GoogleClientSecret string
var GoogleRedirectURI string

func init() {
	godotenv.Load() //loads the .env file
	goth.UseProviders(
		google.New(os.Getenv("GOOGLE_KEY"), os.Getenv("GOOGLE_SECRET"), "http://localhost:3200/api/v1/users/auth/google/callbacksignup", "email", "profile"),
	)
}

func (ac *Auth_controllers) BeginGoogleAuthSignUp(c *gin.Context) {
	q := c.Request.URL.Query()
	q.Add("provider", "google")
	c.Request.URL.RawQuery = q.Encode()
	gothic.BeginAuthHandler(c.Writer, c.Request)
}

func (ac *Auth_controllers) OAuthCallbackSignUp(c *gin.Context) { // #TODO clean this up - @AggressiveGas
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
	//fmt.Println(cookie)
	//fmt.Println("Provider: ",cookie["provider"])
	//fmt.Println("Third Party ID: ",cookie["third_party_id"])
	//fmt.Println("Expires: " ,cookie["expires_at"])

	c.SetCookie("thirdParty_provider", cookie["provider"].(string), 3600, "/", "localhost", false, true)
	c.SetCookie("thirdParty_id", cookie["third_party_id"].(string), 3600, "/", "localhost", false, true)
	c.SetCookie("thirdparty_expires", cookie["expires_at"].(string), 3600, "/", "localhost", false, true)


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
