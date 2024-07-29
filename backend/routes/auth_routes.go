package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Web_Auth_controllers = controllers.Web_Auth_controllers{}
var Auth_controllers = controllers.Auth_controllers{}

func Web_Auth_routes(r *gin.RouterGroup) {

	//GOOGLE AUTH
	r.GET("/google", Web_Auth_controllers.GET_BeginGoogleAuth)

	r.GET("/google/callback", Web_Auth_controllers.GET_GoogleOAuthCallback)

	//LOGOUT  # this doesnt work, never got around to it since deprecated
	//r.GET("/google/logout", controller.POST_logout)
}

func Auth_routes(r *gin.RouterGroup) {

	//Makeing this a post auth route
	//all we do is verify the jwt and set session cookies
	r.POST("/google", Auth_controllers.POST_GoogleAuth)

}
