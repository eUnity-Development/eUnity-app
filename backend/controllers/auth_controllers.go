package controllers

import (
	"context"
	"fmt"
	"os"

	"eunity.com/backend-main/helpers/DBManager"
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

		err = setCookies(result, c)
		if err != nil {
			c.JSON(400, gin.H{
				"response": "Unable to login",
			})
			return
		}

		//make sure cookie has google as provider and it matches the tokenid aud
		if result.ThirdPartyConnections["google"] != payload.Claims["sub"].(string) {
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

	err = setCookies(*new_user, c)
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

func setCookies(user models.User, c *gin.Context) error {
	cookie := generate_secure_cookie(user)

	//set cookie
	c.SetCookie("session_id", cookie["session_id"].(string), 3600, "/", Cookie_Host, HTTPS_only, true)
	c.SetCookie("user_id", cookie["user_id"].(string), 3600, "/", Cookie_Host, HTTPS_only, true)
	c.SetCookie("expires_at", cookie["expires_at"].(string), 3600, "/", Cookie_Host, HTTPS_only, true)

	//turn cookie into bson to store in database
	session_bson := bson.M{
		"session_id": cookie["session_id"].(string),
		"user_id":    cookie["user_id"].(string),
		"expires_at": cookie["expires_at"].(string),
	}

	//add session to session_ids collection
	_, err := DBManager.DB.Collection("session_ids").InsertOne(context.Background(), bson.M{cookie["session_id"].(string): session_bson})

	if err != nil {
		return err
	}

	return nil

}
