package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Feedback_controllers = controllers.Feedback_controllers{}

func Feedback_routes(r *gin.RouterGroup) {
	r.POST("/add", Feedback_controllers.Add_feedback)
}
