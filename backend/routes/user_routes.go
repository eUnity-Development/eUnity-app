package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var User_controllers = controllers.User_controllers{}

func Pub_User_routes(r *gin.RouterGroup) {

	//SIGNUP
	r.POST("/signup", User_controllers.POST_signup)

	//LOGIN
	r.POST("/login", User_controllers.POST_login)

}

func User_routes(r *gin.RouterGroup) {

	//GET ME
	r.GET("/me", User_controllers.GET_me)

	//PATCH ME
	r.PATCH("/me", User_controllers.PATCH_me)

	//LOGOUT
	r.POST("/logout", User_controllers.POST_logout)

	r.GET("/Testing_Context", User_controllers.Testing_Context)

}
