package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Report_User_controllers = controllers.Report_User_controllers{}

func Report_User_routes(r *gin.RouterGroup) {
	//Add a New Report
	r.POST("/add_report", Report_User_controllers.POST_Add_Report)
}
