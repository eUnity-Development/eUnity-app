package controllers

import (
	"context"
	"fmt"
	"reflect"
	"time"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Report_Issue_controllers struct{}

// @Summary Get Unsubmitted Report Issue
// @Schemes
// @Description If the user has an unsubmitted report for an app issue, returns it.
// @Tags Report Issue
// @Accept json
// @Produce json
// @Success 200 {string} Successfully Found Issue Report
// @Success 400 {string} Couldn't Find Issue Report
// @Router /report_issue/get_report [get]
func (rc *Report_Issue_controllers) GET_Get_Issue(c *gin.Context) {
	//Get the user ID from the cookie so we know who is requesting to find their open report
	user_id := c.Keys["user_id"].(string)

	//Search for a report that has the condition that user_id is their user id AND that submitted is false, meaning that the issue report has not been submitted by the user
	search := DBManager.DB.Collection("issue_reports").FindOne(context.Background(), bson.M{"user_id": user_id, "submitted": false})

	//Error Response if no report found.
	if search.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Could not find an open report from the user!",
		})
		return
	}

	//Decode the found report into an IssueReport model
	report := models.IssueReport{}
	err := search.Decode(&report)

	//Error Response if model decoding had a failure
	if err != nil {
		c.JSON(400, gin.H{
			"response": "There was an issue with model conversion!",
		})
		return
	}

	//Successfully return the IssueReport
	c.JSON(200, report)
}

// @Summary Add Report Issue
// @Schemes
// @Description Adds a new Issue Report to the database
// @Tags Report Issue
// @Accept mpfd
// @Produce json
// @Param description formData string false "Issue Description"
// @Param email formData string false "Contact Email"
// @Param media_files formData []string false "Media Files"
// @Success 200 {string} Successfully Added Report
// @Success 400 {string} Couldn't Add Report
// @Router /report_issue/add_report [post]
func (rc *Report_Issue_controllers) POST_Add_Issue(c *gin.Context) {
	//Get the user ID from the cookie so we know who is requesting to find their open report
	user_id := c.Keys["user_id"].(string)

	//Search for a report that has the condition that user_id is their user id AND that submitted is false, meaning that the issue report has not been submitted by the user
	search := DBManager.DB.Collection("issue_reports").FindOne(context.Background(), bson.M{"user_id": user_id, "submitted": false})

	//If a report was found... That's bad. The Patch endpoint is the one that should be used, we only want one open non-submitted issue per user, so we return an error.
	if search.Err() == nil {
		c.JSON(400, gin.H{
			"response": "User already has an open report.",
		})
		return
	}

	//Bind the params to an IssueReport
	var report models.IssueReport
	err := c.Bind(&report)
	if err != nil {
		fmt.Println(err)
		c.JSON(400, gin.H{"response": "Error in Binding JSON"})
		return
	}

	//Init a new Object ID
	objectID := primitive.NewObjectID()

	media_choice := []string{}
	if report.MediaFiles != nil && len(report.MediaFiles) > 0 {
		media_choice = report.MediaFiles
	}

	//Init a new IssueReport struct
	new_report := models.IssueReport{
		ID:               &objectID,
		User_ID:          user_id,
		IssueDescription: report.IssueDescription,
		Contact_Email:    report.Contact_Email,
		Submitted:        false,
		MediaFiles:       media_choice,
		Updated_At:       time.Now(),
	}

	//Attempt to insert into db
	_, err = DBManager.DB.Collection("issue_reports").InsertOne(context.Background(), new_report)
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

// @Summary Patch Unsubmitted Issue Report
// @Schemes
// @Description If the user has an unsubmitted report for an app issue, patches it with the new information
// @Tags Report Issue
// @Accept json
// @Produce json
// @Param data body string true "Data"
// @Success 200 {string} Successfully Patched Issue Report
// @Success 400 {string} Couldn't Patch Issue Report
// @Router /report_issue/update_report [patch]
func (rc *Report_Issue_controllers) PATCH_Update_Issue(c *gin.Context) {

	//Get Report Body
	report := models.IssueReport{}
	err := c.BindJSON(&report)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Error In Binding Body",
		})
		return
	}

	//Get the user ID from the cookie so we know who is requesting to find their open report
	user_id := c.Keys["user_id"].(string)

	//Search for a report that has the condition that user_id is their user id AND that submitted is false, meaning that the issue report has not been submitted by the user
	search := DBManager.DB.Collection("issue_reports").FindOne(context.Background(), bson.M{"user_id": user_id, "submitted": false})

	//If no report was found, handle error
	if search.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Could not find existing report.",
		})
		return
	}
	old_report := models.IssueReport{}
	err = search.Decode(&old_report)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Error In Converting Earlier Report to Model",
		})
		return
	}
	report_id := old_report.ID
	v := reflect.ValueOf(report)
	typeOfUser := v.Type()

	for i := 0; i < v.NumField(); i++ {
		// Get the bson tag of the field
		key := typeOfUser.Field(i).Tag.Get("bson")

		if key == "user_id" {
			continue
		}

		value := v.Field(i)
		//check if nill
		if (value.Kind() == reflect.Ptr || value.Kind() == reflect.Slice || value.Kind() == reflect.Map || value.Kind() == reflect.Interface || value.Kind() == reflect.Chan || value.Kind() == reflect.Func) && value.IsNil() {
			continue
		}

		if (value.Kind() == reflect.Slice || value.Kind() == reflect.Array) && value.Len() == 0 {
			// Handle the case where the value is empty
			continue
		} else {
			_, err = DBManager.DB.Collection("issue_reports").UpdateOne(context.Background(), bson.M{"_id": report_id}, bson.M{"$set": bson.M{key: value.Interface()}})
			if err != nil {
				c.JSON(400, gin.H{
					"response": "Issue In Patching Report",
				})
				return
			}
		}
	}
	DBManager.DB.Collection("issue_reports").UpdateOne(context.Background(), bson.M{"_id": report_id}, bson.M{"$set": bson.M{"updated_at": time.Now()}})
	c.JSON(200, gin.H{
		"response": "Successfully Patched Existing Report",
	})

}

// @Summary Submit Report Issue
// @Schemes
// @Description If the user has an unsubmitted report for an app issue, submits it.
// @Tags Report Issue
// @Accept json
// @Produce json
// @Success 200 {string} Successfully Submitted Issue Report
// @Success 400 {string} Couldn't Submit Issue Report
// @Router /report_issue/submit_report [patch]
func (rc *Report_Issue_controllers) PATCH_Submit_Report(c *gin.Context) {
	//Get the user ID from the cookie so we know who is requesting to find their open report
	user_id := c.Keys["user_id"].(string)

	//Search for a report that has the condition that user_id is their user id AND that submitted is false, meaning that the issue report has not been submitted by the user
	search := DBManager.DB.Collection("issue_reports").FindOne(context.Background(), bson.M{"user_id": user_id, "submitted": false})

	//Error Response if no report found.
	if search.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Could not find an open report from the user!",
		})
		return
	}

	//Decode the found report into an IssueReport model
	report := models.IssueReport{}
	err := search.Decode(&report)

	//Error Response if model decoding had a failure
	if err != nil {
		c.JSON(400, gin.H{
			"response": "There was an issue with model conversion!",
		})
		return
	}

	//Error Response for Empty Description
	if report.IssueDescription == "" {
		c.JSON(400, gin.H{
			"response": "Empty Description is not allowed.",
		})
		return
	}

	//Change report to being marked as submitted
	_, err = DBManager.DB.Collection("issue_reports").UpdateOne(context.Background(), bson.M{"_id": report.ID}, bson.M{"$set": bson.M{"submitted": true}})
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Issue In Marking Report As Submitted",
		})
		return
	}

	c.JSON(200, gin.H{
		"response": "Submitted Report.",
	})
}
