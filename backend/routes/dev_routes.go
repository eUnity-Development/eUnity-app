package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Dev_Controllers = controllers.Dev_Controllers{}

func Dev_routes(r *gin.RouterGroup) {
	//all this routes require user permissons

	//Force Login
	r.GET("/force_login", Dev_Controllers.Force_Login)

	//Generate Mock Users
	r.GET("/generate_mock_users", Dev_Controllers.Generate_Mock_Users)
}
