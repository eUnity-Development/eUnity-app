package routes

import (
	"fmt"

	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var User_controllers = controllers.User_controllers{}

func User_routes(r *gin.RouterGroup) {
	//all this routes require user permissons

	//GET ME
	r.GET("/me", Check_User_Permissions, User_controllers.GET_me)

	//PATCH ME
	r.PATCH("/me", Check_User_Permissions, User_controllers.PATCH_me)

	//LOGOUT
	r.POST("/logout", Check_User_Permissions, User_controllers.POST_logout)

	r.GET("/Testing_Context", Check_User_Permissions, User_controllers.Testing_Context)

}

func Check_User_Permissions(c *gin.Context) {
	//check if user has permissions
	perms := c.MustGet("permissions").([]string)

	fmt.Println(perms)

	for _, perm := range perms {
		if perm == "user" {
			c.Next()
			return
		}
	}

	c.JSON(401, gin.H{
		"response": "Don't have permissions",
	})
	c.Abort()

}
