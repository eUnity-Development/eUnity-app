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

type Report_User_controllers struct{}

// @Summary Add Report User
// @Schemes
// @Description Adds a new User Report to the database
// @Tags Report User
// @Accept mpfd
// @Produce json
// @Param reported_user formData string true "Reported User"
// @Param rule_violations formData []string true "Rule Violations"
// @Param report_comments formData string false "Additional comments that explain why the user was reported"
// @Success 200 {string} Successfully Added Report
// @Success 400 {string} Couldn't Add Report
// @Router /report_user/add_report [post]
func (ru *Report_User_controllers) POST_Add_Report(c *gin.Context) {
	//Get the user ID from the cookie so we know who is requesting to find their open report
	user_id := c.Keys["user_id"].(string)

	//Bind the params to a UserReport
	var report models.UserReport
	err := c.Bind(&report)
	if err != nil {
		fmt.Println(err)
		c.JSON(400, gin.H{"response": "Error in Binding JSON"})
		return
	}

	//Init a new Object ID
	objectID := primitive.NewObjectID()

	//Verify Rule Violations are present
	if report.RuleViolations == nil || len(report.RuleViolations) <= 0 {
		c.JSON(400, gin.H{"response": "Missing Rule Violations"})
		return
	}

	//Verify Reported User is specified
	if report.ReportedUser == "" {
		c.JSON(400, gin.H{"response": "Missing Reported User"})
		return
	}

	//Init a new UserReport struct
	new_report := models.UserReport{
		ID:             &objectID,
		ReportedUser:   report.ReportedUser,
		ReportedBy:     user_id,
		RuleViolations: report.RuleViolations,
		ReportComments: report.ReportComments,
		ReportedAt:     time.Now(),
	}

	//Attempt to insert into db
	_, err = DBManager.DB.Collection("user_reports").InsertOne(context.Background(), new_report)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to Insert Report",
		})
		return
	}

	//Return success code
	c.JSON(200, gin.H{
		"response": "Successfully Created Report",
	})
}
