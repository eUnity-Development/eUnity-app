package controllers

import (
	//"fmt" // for debugging

	"context"
	"fmt"
	"net/http"
	"os" // to access .env file

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/helpers/SessionManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv" // to load .env file
	"github.com/markbates/goth"
	"github.com/markbates/goth/gothic"
	"github.com/markbates/goth/providers/google"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	//"go.mongodb.org/mongo-driver/bson"
	//"go.mongodb.org/mongo-driver/bson/primitive"
)

//we will be using this endpoints for login into the dashboard

type Web_Auth_controllers struct{}

// required google env variables
var GoogleClientID string
var GoogleClientSecret string

// var GoogleRedirectURI string = "http://localhost:3200/api/v1/webAuth/google/callback"
var GoogleRedirectURI string = "https://eunityusa.com/api/v1/webAuth/google/callback"

func init() {

	godotenv.Load() //loads the .env file
	GoogleClientID = os.Getenv("GOOGLE_CLIENT_ID")
	GoogleClientSecret = os.Getenv("GOOGLE_SECRET")

	fmt.Println(GoogleClientID)
	fmt.Println(GoogleClientSecret)

	scopes := []string{
		"email",
		"profile",
	}

	goth.UseProviders(
		google.New(GoogleClientID, GoogleClientSecret, GoogleRedirectURI, scopes...),
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

	//check if the developer is already in the database
	email := user.Email

	dev := DBManager.DB.Collection("whitelisted-devs").FindOne(context.Background(), bson.M{"email": email})
	if dev.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Account not authorized",
		})
	}

	//check if they exists in the developer collection if net we add all their info
	//to the developer collection
	developer := DBManager.DB.Collection("developers").FindOne(context.Background(), bson.M{"email": email})
	fmt.Println(email)
	fmt.Println(user.FirstName)
	fmt.Println(user.LastName)
	fmt.Println(user.Name)
	fmt.Println(user.RawData["verified_email"])
	fmt.Println(user.UserID)

	objectID := primitive.NewObjectID()

	if developer.Err() != nil {
		newDev := models.Developer{
			ID:        &objectID,
			Email:     email,
			FirstName: user.FirstName,
			LastName:  user.LastName,
			AvatarURL: user.AvatarURL,
			Providers: map[string]models.Provider{
				"google": {
					Name:           user.Name,
					Email:          user.Email,
					Email_verified: user.RawData["verified_email"].(bool),
					Sub:            user.UserID,
				},
			},
		}

		fmt.Println("made it here bruh")

		//create a new developer
		_, err := DBManager.DB.Collection("developers").InsertOne(context.Background(), newDev)
		if err != nil {
			c.JSON(400, gin.H{
				"response": "Unable to create developer",
			})
			return
		}
	}

	fmt.Println("made it here bruh 2")

	developer = DBManager.DB.Collection("developers").FindOne(context.Background(), bson.M{"email": email})
	if developer.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Unable to login",
		})
		return
	}

	var result models.Developer
	err = developer.Decode(&result)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to login",
		})
		return

	}

	_, err = SessionManager.Create_Developer_Session(result.ID.Hex(), c)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to login",
		})
		return

	}

	//after this we want to create a session

	//we need to implement the rest for web auth here we would create the user etc, etc
	//redirect to /dashboard should have access to all the developer endpoints
	c.Redirect(http.StatusMovedPermanently, "/dashboard")

}
