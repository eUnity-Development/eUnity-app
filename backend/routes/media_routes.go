package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Media_controllers = controllers.Media_controllers{}

func Media_routes(r *gin.RouterGroup) {

	r.POST("/user_image", Media_controllers.Add_user_image)

	r.GET("/user_image/:image_id", Media_controllers.Get_user_image)

	r.DELETE("/user_image/:image_id", Media_controllers.Delete_user_image)

}
