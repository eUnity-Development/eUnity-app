package controllers

import (
	//"fmt" // for debugging
	"encoding/json"
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

// required google env variables
var GoogleClientID string
var GoogleClientSecret string
var GoogleRedirectURI string = "http://localhost:3200/api/v1/auth/google/callback"

//this other url will redirect to the app under the schema eunity://open.my.app.com -> we can change this later
//then we can call the correct callback url from withing the app. using 10.0.2.2

//var GoogleRedirectURI string = "https://eunityusa.com/api/v1/redirect_google_auth_app"

func init() {

	godotenv.Load() //loads the .env file
	Google_key := os.Getenv("GOOGLE_KEY")
	Google_secret := os.Getenv("GOOGLE_SECRET")
	fmt.Println(Google_key)
	fmt.Println(Google_secret)

	scopes := []string{
		"email",
		"profile",
	}

	goth.UseProviders(
		google.New(Google_key, Google_secret, GoogleRedirectURI, scopes...),
	)
}

// @Summary Begin Google Auth
// @Description Begins the google auth process
// @Tags Auth
// @Accept json
// @Produce json
// @Success 200 {string} string "Google Auth Started"
// @Router /auth/google [get]
func (ac *Auth_controllers) GET_BeginGoogleAuth(c *gin.Context) {

	//request quert handler object
	q := c.Request.URL.Query()

	//add this to the query
	q.Add("provider", "google")

	//encode the query
	c.Request.URL.RawQuery = q.Encode()

	//begin the auth handler with gothic
	gothic.BeginAuthHandler(c.Writer, c.Request)
}

// @Summary Google OAuth Callback
// @Description Callback for google auth
// @Tags Auth
// @Accept json
// @Produce json
// @Success 200 {string} string "Google Auth Callback"
// @Router /auth/google/callback [get]
func (ac *Auth_controllers) GET_GoogleOAuthCallback(c *gin.Context) { // #TODO clean this up - @AggressiveGas
	q := c.Request.URL.Query()
	q.Add("provider", "google")
	c.Request.URL.RawQuery = q.Encode()
	//view entire query data

	fmt.Println(c.Request.URL.Query())

	user, err := gothic.CompleteUserAuth(c.Writer, c.Request)
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
		return
	}

	fmt.Println("right here")
	// print the user as pretty json and save to file
	jsonObject, err := json.MarshalIndent(user, "", "    ")
	if err != nil {
		fmt.Println(err)
		return
	}

	//save to file
	err = os.WriteFile("user.json", jsonObject, 0644)
	if err != nil {

		fmt.Println(err)
		return

	}

	//print the user
	fmt.Println(string(jsonObject))

	//@TODO make the cookie here
	cookie := generate_secure_cookie_third_party(user)
	fmt.Println(cookie)
	fmt.Println("Provider: ", cookie["provider"])
	fmt.Println("Third Party ID: ", cookie["third_party_id"])
	fmt.Println("Expires: ", cookie["expires_at"])

	c.SetCookie("thirdParty_provider", cookie["provider"].(string), 3600, "/", Cookie_Host, HTTPS_only, true)
	c.SetCookie("thirdParty_id", cookie["third_party_id"].(string), 3600, "/", Cookie_Host, HTTPS_only, true)
	c.SetCookie("thirdparty_expires", cookie["expires_at"].(string), 3600, "/", Cookie_Host, HTTPS_only, true)

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
