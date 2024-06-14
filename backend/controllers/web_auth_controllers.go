package controllers

import (
	//"fmt" // for debugging
	"encoding/json"
	"fmt"
	"net/http"
	"os" // to access .env file

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv" // to load .env file
	"github.com/markbates/goth"
	"github.com/markbates/goth/gothic"
	"github.com/markbates/goth/providers/google"
	//"go.mongodb.org/mongo-driver/bson"
	//"go.mongodb.org/mongo-driver/bson/primitive"
)

type Web_Auth_controllers struct{}

// required google env variables
var GoogleClientID string
var GoogleClientSecret string
var GoogleRedirectURI string = "http://localhost:3200/api/v1/webAuth/google/callback"

//this other url will redirect to the app under the schema eunity://open.my.app.com -> we can change this later
//then we can call the correct callback url from withing the app. using 10.0.2.2

//var GoogleRedirectURI string = "https://eunityusa.com/api/v1/redirect_google_auth_app"

func init() {

	godotenv.Load() //loads the .env file
	Google_key := os.Getenv("GOOGLE_KEY")
	Google_secret := os.Getenv("GOOGLE_SECRET")

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
// @Tags Web Auth
// @Accept json
// @Produce json
// @Success 200 {string} string "Google Auth Started"
// @Router /webAuth/google [get]
func (ac *Web_Auth_controllers) GET_BeginGoogleAuth(c *gin.Context) {

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
// @Tags Web Auth
// @Accept json
// @Produce json
// @Success 200 {string} string "Google Auth Callback"
// @Router /webAuth/google/callback [get]
func (ac *Web_Auth_controllers) GET_GoogleOAuthCallback(c *gin.Context) { // #TODO clean this up - @AggressiveGas
	q := c.Request.URL.Query()
	q.Add("provider", "google")
	c.Request.URL.RawQuery = q.Encode()
	//view entire query data

	user, err := gothic.CompleteUserAuth(c.Writer, c.Request)
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
		return
	}

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

	//we need to implement the rest for web auth here we would create the user etc, etc
	c.JSON(200, "have not yet implemented the rest of the web auth process")

}