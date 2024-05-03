package controllers

import "github.com/gin-gonic/gin"

// create empty struct to attach methods to
type User_controllers struct {
}

// @Summary User test route
// @Schemes
// @Description returns a string from user routes
// @Tags example
// @Accept json
// @Produce json
// @Success 200 {string} Hello from user routes
// @Router /users/me [get]
func (u *User_controllers) GET_me(c *gin.Context) {
	c.JSON(200, "Hello from user routes")
}
