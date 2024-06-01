package main

import (
	"net/http"

	docs "eunity.com/backend-main/docs"
	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/helpers/TwilioManager"
	"eunity.com/backend-main/routes"
	"github.com/gin-gonic/gin"
	swaggerfiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

func main() {

	//init server
	router := gin.Default()

	//init DbManager
	DBManager.Init()
	TwilioManager.Init()

	//set default endpoint
	docs.SwaggerInfo.BasePath = "/api/v1"
	r := router.Group("/api/v1")
	//ROUTE GROUPS
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//set up routes
	routes.User_routes(r.Group("/users"))
	routes.TwilioRoutes(r.Group("/twilio"))

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// Serve Swagger UI at /docs
	router.GET("/docs", func(c *gin.Context) {
		c.Redirect(http.StatusMovedPermanently, "/docs/index.html")
	})
	router.GET("/docs/*any", ginSwagger.WrapHandler(
		swaggerfiles.Handler,
	))
	router.Run(":3200")
	defer DBManager.Disconnect()
}
