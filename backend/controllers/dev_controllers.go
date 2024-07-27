// routes are only for development purposes
package controllers

import (
	"context"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/helpers/MockUsersGen"
	"eunity.com/backend-main/helpers/SessionManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
)

type Dev_Controllers struct {
}

// @Summary Force Login
// @Description Creates a session for a user by email
// @Tags Dev
// @Accept json
// @Produce json
// @Param email query string true "email"
// @Success 200 {string} response "Session created, user logged in"
// @Router /dev/force_login [get]
func (d *Dev_Controllers) Force_Login(c *gin.Context) {
	//take in email and force creates a session for that user
	//this is only for development purposes

	//get email from query
	email := c.Query("email")

	//get user from email
	user := models.User{}
	err := DBManager.DB.Collection("users").FindOne(context.Background(), bson.M{"email": email}).Decode(&user)

	if err != nil {
		c.JSON(400, gin.H{
			"response": "User not found",
		})
		return
	}

	//create session
	_, err = SessionManager.Create_Session(user.ID.Hex(), c)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to create session",
		})
		return
	}

	c.JSON(200, gin.H{
		"response": "Session created, user logged in",
	})
}

// @Summary Create Mock Users
// @Schemes
// @Description Creates mock users for development purposes
// @Tags Dev
// @Accept json
// @Produce json
// @Success 200 {string} response "Mock users created"
// @Router /dev/generate_mock_users [get]
func (d *Dev_Controllers) Generate_Mock_Users(c *gin.Context) {
	//create mock users for development purposes
	err := MockUsersGen.Gen_Mock_Users()
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to create mock users" + err.Error(),
		})
		return
	}

	c.JSON(200, gin.H{
		"response": "Mock users created",
	})
}
