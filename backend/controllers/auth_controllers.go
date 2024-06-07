package controllers

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
	"google.golang.org/api/idtoken"
)

type Auth_controllers struct{}

var client_id string

func init() {
	client_id = os.Getenv("GOOGLE_CLIENT_ID")
}

// @Summary Google Auth
// @Description Accepts jwt idToken from flutter and sets session cookies
// @Tags Auth
// @Accept json
// @Produce json
// @Param idToken query string true "idToken"
// @Success 200 {string} string "Google Auth Started"
// @Router /auth/google [post]
func (ac *Auth_controllers) POST_GoogleAuth(c *gin.Context) {

	idToken := c.Query("idToken")

	//verify the token
	token, err := verifyToken(idToken)
	if err != nil {
		c.JSON(400, err.Error())
		return
	}

	fmt.Println(token)
	//check if the user is in the database
	//if not we create the user and set then set the session cookies

	c.JSON(200, "Google Auth Started")

}

func verifyToken(token string) (string, error) {
	// Create a new ID token verifier.
	fmt.Println(token)

	payload, err := idtoken.Validate(context.Background(), token, client_id)
	if err != nil {
		fmt.Println("Error validating token", err)
		return "", err
	}

	// Get the user's email address.
	email := payload.Claims["email"].(string)

	//turn the payload into json
	jsonPayload, err := json.Marshal(payload)
	if err != nil {
		fmt.Println("Error marshalling payload", err)
		return "", err
	}

	jsonString := string(jsonPayload)

	// Print the user's email address.
	fmt.Println(email)

	return jsonString, nil
}
