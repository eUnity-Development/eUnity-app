package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Swipe_Controllers = controllers.Swipe_Controllers{}

func Swipe_Routes(r *gin.RouterGroup) {
	//Add a New Swipe
	r.POST("/add_swipe", Swipe_Controllers.POST_Add_Swipe)
}
