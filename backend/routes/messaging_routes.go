package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Messaging_controllers = controllers.Messaging_controllers{}

func Messaging_routes(r *gin.RouterGroup) {
	r.GET("/ws", Messaging_controllers.Web_Socket_Connection)
	r.POST("/send", Messaging_controllers.Send_message)

}
