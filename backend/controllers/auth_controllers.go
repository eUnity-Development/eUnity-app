package controllers

import (
	"context"
	"fmt"
	"os"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/helpers/SessionManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
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
	payload, err := verifyToken(idToken)
	if err != nil {
		c.JSON(400, err.Error())
		return
	}

	email := payload.Claims["email"].(string)

	//search if user exists in db by email
	user := DBManager.DB.Collection("users").FindOne(context.Background(), bson.M{"email": email})

	//if user exists set cookies and return
	if user.Err() == nil {
		session_id, err := c.Cookie("session_id")
		if err == nil {
			session := DBManager.DB.Collection("session_ids").FindOne(context.Background(), bson.M{session_id: bson.M{"$exists": true}})
			if session.Err() == nil {
				c.JSON(400, gin.H{
					"response": "Already logged in",
				})
				return

			}
		}

		var result models.User
		err = user.Decode(&result)
		if err != nil {
			c.JSON(400, gin.H{
				"response": "Unable to login",
			})
			return
		}

		//make sure cookie has google as provider and it matches the tokenid aud
		//need to modify this part, say the user does not have google as provider
		//we need to add google as a provider and if the email is not confirmed we need to update it
		//we need to check if the emails are the same
		if result.Providers["google"].Sub != payload.Claims["sub"].(string) {
			//check if google provider exists
			if _, ok := result.Providers["google"]; !ok {
				result.Providers["google"] = models.Provider{
					Name:           payload.Claims["name"].(string),
					Email:          payload.Claims["email"].(string),
					Email_verified: payload.Claims["email_verified"].(bool),
					Sub:            payload.Claims["sub"].(string),
				}
				result.Verified_email = payload.Claims["email_verified"].(bool)
				_, err = DBManager.DB.Collection("users").UpdateOne(context.Background(), bson.M{"email": email}, bson.M{"$set": result})
				if err != nil {
					c.JSON(400, gin.H{
						"response": "Unable to add google provider",
					})
					return
				}
			} else {
				c.JSON(400, gin.H{
					"response": "Unable to login",
				})
				return
			}

		}

		_, err = SessionManager.Create_Session(result.ID.Hex(), c)
		if err != nil {
			c.JSON(400, gin.H{
				"response": "Unable to login",
			})
			return
		}

		c.JSON(200, gin.H{
			"response": "Login Successful",
		})
		return
	}

	//if user does not exist create user from payload

	new_user := models.FromGooglePayload(payload)
	_, err = DBManager.DB.Collection("users").InsertOne(context.Background(), new_user)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Error creating user",
		})
		return
	}

	_, err = SessionManager.Create_Session(new_user.ID.Hex(), c)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to login",
		})
		return
	}

	c.JSON(200, "Google Auth Started")

}

func verifyToken(token string) (*idtoken.Payload, error) {
	// Create a new ID token verifier.

	payload, err := idtoken.Validate(context.Background(), token, client_id)
	if err != nil {
		fmt.Println("Error validating token", err)
		return nil, err
	}

	return payload, nil
}
