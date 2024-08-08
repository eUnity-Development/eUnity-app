package controllers

import (
	"context"
	"time"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type AI_Analysis_controllers struct{}

// @Summary Create an AI Analysis
// @Schemes
// @Description Creates an AI Analysis for the user profile
// @Tags AI Analysis
// @Accept json
// @Produce json
// @Success 200 {string} Successfully Created AI Analysis
// @Success 400 {string} Couldn't Create AI Analysis
// @Router /ai_analysis/create_analysis [post]
func (au *AI_Analysis_controllers) POST_Create_AI_Analysis(c *gin.Context) {
	//Get the user ID from the cookie so we know who is requesting to find their open report
	user_id := c.Keys["user_id"].(string)

	ai_analysis := models.AI_Analysis{
		UserID:          user_id,
		BioAnalysis:     "Nice bio dude, but I recommend adding your opinion on the ideal pizza topping",
		PhotoAnalysis:   "Add dog photos, people love dogs.",
		OverallAnalysis: "Overall, your profile is mid and you need to get good at life",
		Timestamp:       time.Now(),
	}

	//Attempt to insert into db
	_, err := DBManager.DB.Collection("ai_analysis").InsertOne(context.Background(), ai_analysis)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to Insert AI Analysis",
		})
		return
	}

	//Return success code
	c.JSON(200, gin.H{
		"response": "Successfully Created Report",
	})
}

// @Summary Gets the AI Analysis
// @Schemes
// @Description Gets the most recent AI Analysis of the user
// @Tags AI Analysis
// @Accept json
// @Produce json
// @Success 200 {string} Successfully Fetched AI Analysis
// @Success 400 {string} Couldn't Fetch AI Analysis
// @Router /ai_analysis/get_analysis [get]
func (au *AI_Analysis_controllers) GET_Get_AI_Analysis(c *gin.Context) {

	//Get the user ID from the cookie so we know who is requesting to find their open report
	user_id := c.Keys["user_id"].(string)

	opts := options.FindOne().SetSort(bson.D{{Key: "timestamp", Value: -1}})
	analysis := DBManager.DB.Collection("ai_analysis").FindOne(context.Background(), bson.M{"user_id": user_id}, opts)
	if analysis.Err() != nil {
		c.JSON(400, gin.H{
			"response": "No Analysis found",
		})
		return
	}

	result := models.AI_Analysis{}
	err := analysis.Decode(&result)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "No analysis found",
		})
		return
	}

	c.JSON(200, result)

}
