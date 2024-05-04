package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var controller = controllers.User_controllers{}

func User_routes(r *gin.RouterGroup) {
	r.GET("/me", controller.GET_me)

	//SIGNUP
	r.POST("/signup", controller.POST_signup)

	//LOGIN
	r.POST("/login", controller.POST_login)

}
