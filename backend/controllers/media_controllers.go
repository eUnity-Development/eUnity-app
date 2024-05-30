package controllers

import (
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
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

	//get user_id from cookies
	user_id, err := c.Cookie("user_id")
	if err != nil {
		c.JSON(401, gin.H{
			"response": "Unauthorized",
		})
		return
	}

	//we generate an id for the image
	//we will use the user_id as the folder name
	image_id := generate_secure_token(10)

	//take image and save it images file
	//attach original extension to the image

	file, _ := c.FormFile("image")
	c.SaveUploadedFile(file, "images/"+user_id+"/"+image_id+".jpg")

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
	fmt.Println("Get_user_image")
	//get user_id from cookies
	user_id, err := c.Cookie("user_id")
	if err != nil {
		c.JSON(401, gin.H{
			"response": "Unauthorized",
		})
		return
	}

	//get image_id from params
	image_id := c.Param("image_id")

	//return image
	c.File("images/" + user_id + "/" + image_id + ".jpg")
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
	user_id, err := c.Cookie("user_id")
	if err != nil {
		c.JSON(401, gin.H{
			"response": "Unauthorized",
		})
		return
	}
	//get image_id from params
	image_id := c.Param("image_id")

	//delete image
	err = os.Remove("images/" + user_id + "/" + image_id + ".jpg")
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
	c.File("images/" + user_id + "/" + image_id + ".jpg")
}
