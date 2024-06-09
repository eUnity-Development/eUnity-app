package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var controller = controllers.User_controllers{}

func User_routes(r *gin.RouterGroup) {

	//SIGNUP
	r.POST("/signup", controller.POST_signup)

	//LOGIN
	r.POST("/login", controller.POST_login)

}

func Protected_user_routes(r *gin.RouterGroup) {

	//GET ME
	r.GET("/me", controller.GET_me)

	//PATCH ME
	r.PATCH("/me", controller.PATCH_me)

	//LOGOUT
	r.POST("/logout", controller.POST_logout)

}
