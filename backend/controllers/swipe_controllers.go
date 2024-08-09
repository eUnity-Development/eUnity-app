package controllers

import (
	"context"
	"fmt"
	"time"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Swipe_Controllers struct{}

// @Summary Add Swipe
// @Schemes
// @Description Adds a new Swipe record to the database
// @Tags Swipe
// @Accept mpfd
// @Produce json
// @Param swiped_user formData string true "Swiped User"
// @Param swiped_direction formData bool true "Swiped Direction (true for right, false for left)"
// @Success 200 {string} Successfully Added Swipe
// @Success 400 {string} Couldn't Add Swipe
// @Router /swipe/add_swipe [post]
func (sc *Swipe_Controllers) POST_Add_Swipe(c *gin.Context) {
	// Get the user ID from the context (e.g., from session or token)
	userID := c.Keys["user_id"].(string)

	// Bind the form data to a Swipe model instance
	var swipe models.Swipe
	err := c.Bind(&swipe)
	if err != nil {
		fmt.Println(err)
		c.JSON(400, gin.H{"response": "Error in Binding JSON"})
		return
	}

	// Verify that the SwipedUser and SwipedDirection are provided
	if swipe.SwipedUser == "" {
		c.JSON(400, gin.H{"response": "Missing Swiped User"})
		return
	}

	// Initialize a new Object ID
	objectID := primitive.NewObjectID()

	// Create a new Swipe struct
	newSwipe := models.Swipe{
		ID:            &objectID,
		SwipedUser:    swipe.SwipedUser,
		SwipedBy:      userID,
		CreatedAt:     time.Now(),
		IsSwipedRight: swipe.IsSwipedRight,
	}

	// Attempt to insert into the database
	_, err = DBManager.DB.Collection("swipes").InsertOne(context.Background(), newSwipe)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to Insert Swipe",
		})
		return
	}

	// Return success code
	c.JSON(200, gin.H{
		"response": "Successfully Added Swipe",
	})
}
