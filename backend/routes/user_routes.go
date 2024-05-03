package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

// @Summary User test route
// @Schemes
// @Description returns a string from user routes
// @Tags example
// @Accept json
// @Produce json
// @Success 200 {string} Hello from user routes
// @Router /users/me [get]
var controller = controllers.User_controllers{}

func User_routes(r *gin.RouterGroup) {
	r.GET("/me", controller.GET_me)
}
