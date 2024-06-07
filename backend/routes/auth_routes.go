package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Auth_controllers = controllers.Auth_controllers{}

func Auth_routes(r *gin.RouterGroup) {

	//GOOGLE AUTH
	r.GET("/google", Auth_controllers.GET_BeginGoogleAuth)

	r.GET("/google/callback", Auth_controllers.GET_GoogleOAuthCallback)

	//LOGOUT #TODO: make this work @AggressiveGas
	//r.GET("/google/logout", controller.POST_logout)
}
