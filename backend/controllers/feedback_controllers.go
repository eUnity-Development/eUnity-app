package controllers

import (
	"context"
	"fmt"
	"time"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	//"go.mongodb.org/mongo-driver/bson/primitive"
)

type Feedback_controllers struct{}

// @Summary Add Feedback
// @Description Add feedback from a user
// @Tags Feedback
// @Accept json
// @Produce json
// @Param user query string true "User ID"
// @Param stars query int true "Stars"
// @Param positive_text query string true "Positive Text"
// @Param negative_text query string true "Negative Text"
// @Success 200 {string} string "Feedback added successfully!"
// @Router /feedback/add [post]
func (fc *Feedback_controllers) Add_feedback(c *gin.Context) {
	
	var feedback models.Feedback
	err := c.Bind(&feedback)
	if err != nil {
		fmt.Println(err, "Error binding JSON")
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}
	
	//currentTime := time.Now()
	//formattedTime := currentTime.Format("2006-01-02 15:04:05")


	user := feedback.User
	stars := feedback.Stars
	positive_text := feedback.Positive_text
	negative_text := feedback.Negative_text
	feedback.Submitted_at = time.Now() 
	//@TODO change to nicer time formatting
	//Add validation for required fields
	//check for user id. @AggressiveGas

	// Checks for missing required fields, and correct star values
	if user == "" || stars == 0|| stars < 0 || stars > 5 || positive_text == "" || negative_text == "" {
		c.JSON(400, gin.H{
			"response": "Missing required fields!",
		})
		return
	}

	//create new feedback
	newFeedback := models.Feedback{
		User:          user,
		Stars:         stars,
		Positive_text: positive_text,
		Negative_text: negative_text,
		Submitted_at:  feedback.Submitted_at,
	}

	//insert feedback into db
	_, err = DBManager.DB.Collection("feedback").InsertOne(context.Background(),newFeedback)
	if err != nil {
		fmt.Println(err)
		c.JSON(400, gin.H{
			"response": "Error adding feedback!",
		})
		return
	}
	c.JSON(200, gin.H{"response": "Feedback added successfully!"})

	/*
	fmt.Println("Time: ", formattedTime)
	fmt.Println("user: ", user)
	fmt.Println("stars: ", stars)
	fmt.Println("positive_text: ", positive_text)
	fmt.Println("negative_text: ", negative_text)
	*/

}

// @Summary Get Feedback
// @Description Get all feedback
// @Tags Feedback
// @Accept json
// @Produce json
// @Success 200 {string} string "Feedback retrieved successfully!"
// @Router /feedback/get [get]
func (fc *Feedback_controllers) Get_feedback(c *gin.Context) {
	var feedback models.Feedback
	err := c.ShouldBind(&feedback)
	if err != nil {
		fmt.Println(err, "Error binding JSON")
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}

	usercheck := feedback.User

	cursor, err := DBManager.DB.Collection("feedback").Find(context.Background(), bson.M{"user": usercheck})
	if err != nil {
		c.JSON(500, gin.H{"error": "Error finding user feedback"})
		return
	}
	defer cursor.Close(context.Background())

	var results []models.Feedback
	for cursor.Next(context.Background()) {
		var result models.Feedback
		err := cursor.Decode(&result)
		if err != nil {
			fmt.Println(err, "Error decoding feedback")
			c.JSON(500, gin.H{"error": "Error decoding feedback"})
			return
		}
		results = append(results, result)
	}

	if err := cursor.Err(); err != nil {
		c.JSON(400, gin.H{"error": "Cursor error"})
		return
	}

	c.JSON(200, results)
}


// @Summary Get All Feedback
// @Description Get all feedback
// @Tags Feedback
// @Accept json
// @Produce json
// @Success 200 {string} string "Feedback retrieved successfully!"
// @Router /feedback/getall [get]
func (fc *Feedback_controllers) Get_all_feedback(c *gin.Context) {
	cursor, err := DBManager.DB.Collection("feedback").Find(context.Background(), bson.M{})
	if err != nil {
		c.JSON(400, gin.H{"error": "Error finding feedback"})
		return
	}
	defer cursor.Close(context.Background())

	var results []models.Feedback
	for cursor.Next(context.Background()) {
		var result models.Feedback
		err := cursor.Decode(&result)
		if err != nil {
			fmt.Println(err, "Error decoding feedback")
			c.JSON(400, gin.H{"error": "Error decoding feedback"})
			return
		}
		results = append(results, result)
	}

	if err := cursor.Err(); err != nil {
		c.JSON(400, gin.H{"error": "Cursor error"})
		return
	}

	c.JSON(200, results)
}