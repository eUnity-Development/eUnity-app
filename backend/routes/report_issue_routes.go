package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Report_Issue_controllers = controllers.Report_Issue_controllers{}

func Report_Issue_routes(r *gin.RouterGroup) {

	//Return Unsubmitted Report
	r.GET("/get_report", Report_Issue_controllers.GET_Get_Issue)

	//Add a New Report
	r.POST("/add_report", Report_Issue_controllers.POST_Add_Issue)

	//Update the existing Unsubmitted Report
	r.PATCH("/update_report", Report_Issue_controllers.PATCH_Update_Issue)

	//Submit the current unsubmitted report
	r.PATCH("/submit_report", Report_Issue_controllers.PATCH_Submit_Report)
}
