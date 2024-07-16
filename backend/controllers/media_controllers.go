package controllers

import (
	"context"
	"fmt"
	"os"
	"path/filepath"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Media_controllers struct {
}

// @Summary Adds user image
// @Schemes
// @Uploads image and adds it to user profile
// @Tags Media
// @Accept image/jpeg
// @Produce json
// @Param image formData file true "Image"
// @Success 200 {string} Image ID
// @Router /media/user_image [post]
func (m *Media_controllers) Add_user_image(c *gin.Context) {

	file, _ := c.FormFile("image")

	//get file extension from Header
	extension := filepath.Ext(file.Filename)
	//get user_id from cookies
	user_id := c.Keys["user_id"].(string)

	//we generate an id for the image
	//we will use the user_id as the folder name
	image_id := uuid.New().String() + extension

	//check how many images the user has in the database
	//if the user has more than 9 images, return error
	bson_user_id, err := primitive.ObjectIDFromHex(user_id)
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}

	user := DBManager.DB.Collection("users").FindOne(context.Background(), bson.M{"_id": bson_user_id})
	if user.Err() != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}
	var user_obj models.User
	err = user.Decode(&user_obj)
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}
	if len(user_obj.MediaFiles) >= 9 {
		c.JSON(400, gin.H{
			"response": "User has reached maximum number of images",
		})
	}
	link := "http://localhost:3200/api/v1/media/" + user_id + "/" + image_id
	//add image to user profile
	_, err = DBManager.DB.Collection("users").UpdateOne(context.Background(), bson.M{"_id": bson_user_id}, bson.M{"$push": bson.M{"media_files": link}})
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
	}

	c.SaveUploadedFile(file, "images/"+user_id+"/"+image_id)

	//return param as json
	c.JSON(200, gin.H{
		"image_id": image_id,
	})
}

// @Summary Gets user image
// @Schemes
// @Returns image
// @Tags Media
// @Accept json
// @Produce image/jpeg
// @Param image_id path string true "Image ID"
// @Success 200 {string} Image
// @Router /media/user_image/{image_id} [get]
func (m *Media_controllers) Get_user_image(c *gin.Context) {
	//get user_id from cookies
	user_id := c.Keys["user_id"].(string)

	//get image_id from params
	image_id := c.Param("image_id")

	//return image
	c.File("images/" + user_id + "/" + image_id)
}

// @Summary Deletes user image
// @Schemes
// @Deletes image from user profile
// @Tags Media
// @Accept json
// @Produce json
// @Param image_id path string true "Image ID"
// @Success 200 {string} Image ID
// @Router /media/user_image/{image_id} [delete]
func (m *Media_controllers) Delete_user_image(c *gin.Context) {
	//get user_id from cookies
	user_id := c.Keys["user_id"].(string)

	bson_user_id, err := primitive.ObjectIDFromHex(user_id)
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}

	//get image_id from params
	image_id := c.Param("image_id")

	//delete image from user profile
	_, err = DBManager.DB.Collection("users").UpdateOne(context.Background(), bson.M{"_id": bson_user_id}, bson.M{"$pull": bson.M{"media_files": "http://localhost:3200/api/v1/media/" + user_id + "/" + image_id}})
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}

	//delete image
	err = os.Remove("images/" + user_id + "/" + image_id)
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}

	//return image_id
	c.JSON(200, gin.H{
		"image_id": image_id,
	})
}

// @Summary Gets image -> unprotected route
// @Schemes
// @Returns image
// @Tags Public Media
// @Accept json
// @Produce image/jpeg
// @Param user_id path string true "User ID"
// @Param image_id path string true "Image ID"
// @Success 200 {string} Image
// @Router /media/{user_id}/{image_id} [get]
func (m *Media_controllers) Get_Image(c *gin.Context) {
	//get user_id from params
	user_id := c.Param("user_id")

	//get image_id from params
	image_id := c.Param("image_id")

	//return image
	c.File("images/" + user_id + "/" + image_id)
}

// TODO
// Change potentially change this later as the image logic changes above.
// Done by Dylan, will be fixed by me if problems arise.
//Essentially re-skin the first 4 routes to work for the reports instead

// @Summary Adds Report image
// @Schemes
// @Uploads image and adds it to the current Issue Report
// @Tags Media
// @Accept image/jpeg
// @Produce json
// @Param image formData file true "Image"
// @Success 200 {string} Image ID
// @Router /media/report_image [post]
func (m *Media_controllers) Add_report_image(c *gin.Context) {

	file, _ := c.FormFile("image")

	//get file extension from Header
	extension := filepath.Ext(file.Filename)
	//get user_id from cookies
	user_id := c.Keys["user_id"].(string)

	//Find the relevant open report
	search := DBManager.DB.Collection("issue_reports").FindOne(context.Background(), bson.M{"user_id": user_id, "submitted": false})

	//If no report was found, handle error
	if search.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Could not find existing report.",
		})
		return
	}

	//Get the report ID
	report := models.IssueReport{}
	err := search.Decode(&report)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Error In Converting Earlier Report to Model",
		})
		return
	}
	report_id := report.ID

	//we generate an id for the image
	//we will use the user_id as the folder name
	image_id := uuid.New().String() + extension

	//Ensure theres not more than 3 images attached
	if len(report.MediaFiles) >= 3 {
		c.JSON(400, gin.H{
			"response": "Issue Report has reached maximum amount of images!",
		})
		return
	}

	link := "http://localhost:3200/api/v1/media/reports/" + report_id.Hex() + "/" + image_id

	//Add image to report
	_, err = DBManager.DB.Collection("issue_reports").UpdateOne(context.Background(), bson.M{"_id": report_id}, bson.M{"$push": bson.M{"media_files": link}})
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}

	err = c.SaveUploadedFile(file, "images/reports/"+report_id.Hex()+"/"+image_id)
	fmt.Println(err)

	//return param as json
	c.JSON(200, gin.H{
		"image_id": image_id,
	})
}

// @Summary Gets report image
// @Schemes
// @Returns image
// @Tags Media
// @Accept json
// @Produce image/jpeg
// @Param image_id path string true "Image ID"
// @Success 200 {string} Image
// @Router /media/report_image/{image_id} [get]
func (m *Media_controllers) Get_report_image(c *gin.Context) {
	//get user_id from cookies
	user_id := c.Keys["user_id"].(string)

	//get image_id from params
	image_id := c.Param("image_id")

	//Find the relevant open report
	search := DBManager.DB.Collection("issue_reports").FindOne(context.Background(), bson.M{"user_id": user_id, "submitted": false})

	//If no report was found, handle error
	if search.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Could not find existing report.",
		})
		return
	}

	//Get the report ID
	report := models.IssueReport{}
	err := search.Decode(&report)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Error In Converting Earlier Report to Model",
		})
		return
	}
	report_id := report.ID

	//return image
	c.File("images/reports/" + report_id.Hex() + "/" + image_id)
}

// @Summary Deletes issue report image
// @Schemes
// @Deletes image from issue report
// @Tags Media
// @Accept json
// @Produce json
// @Param image_id path string true "Image ID"
// @Success 200 {string} Image ID
// @Router /media/report_image/{image_id} [delete]
func (m *Media_controllers) Delete_report_image(c *gin.Context) {
	//get user_id from cookies
	user_id := c.Keys["user_id"].(string)

	//Find the relevant open report
	search := DBManager.DB.Collection("issue_reports").FindOne(context.Background(), bson.M{"user_id": user_id, "submitted": false})

	//If no report was found, handle error
	if search.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Could not find existing report.",
		})
		return
	}

	//Get the report ID
	report := models.IssueReport{}
	err := search.Decode(&report)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Error In Converting Earlier Report to Model",
		})
		return
	}
	report_id := report.ID

	//get image_id from params
	image_id := c.Param("image_id")

	//delete image from issue report
	_, err = DBManager.DB.Collection("issue_reports").UpdateOne(context.Background(), bson.M{"_id": report_id}, bson.M{"$pull": bson.M{"media_files": "http://localhost:3200/api/v1/media/reports/" + report_id.Hex() + "/" + image_id}})
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}

	//delete image
	err = os.Remove("images/reports/" + report_id.Hex() + "/" + image_id)
	if err != nil {
		c.JSON(500, gin.H{
			"response": "Internal Server Error",
		})
		return
	}

	//return image_id
	c.JSON(200, gin.H{
		"image_id": image_id,
	})
}

// @Summary Gets image -> unprotected route
// @Schemes
// @Returns image
// @Tags Public Media
// @Accept json
// @Produce image/jpeg
// @Param report_id path string true "Report ID"
// @Param image_id path string true "Image ID"
// @Success 200 {string} Image
// @Router /media/reports/{report_id}/{image_id} [get]
func (m *Media_controllers) Get_ReportImage(c *gin.Context) {
	//get report_id from params
	report_id := c.Param("report_id")

	//get image_id from params
	image_id := c.Param("image_id")

	//return image
	c.File("images/reports/" + report_id + "/" + image_id)
}
