package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var AI_Analysis_controllers = controllers.AI_Analysis_controllers{}

func AI_Analysis_routes(r *gin.RouterGroup) {

	//GET AI ANALYSIS
	r.GET("/get_analysis", AI_Analysis_controllers.GET_Get_AI_Analysis)

	//CREATE AI ANALYSIS
	r.POST("/create_analysis", AI_Analysis_controllers.POST_Create_AI_Analysis)

}
