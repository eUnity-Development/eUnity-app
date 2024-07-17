package main

import (
	"net/http"

	docs "eunity.com/backend-main/docs"
	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/helpers/SessionManager"
	"eunity.com/backend-main/helpers/TwilioManager"
	"eunity.com/backend-main/routes"
	"github.com/gin-gonic/gin"
	swaggerfiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

func main() {

	//init server
	router := gin.Default()

	//set default endpoint
	docs.SwaggerInfo.BasePath = "/api/v1"
	r := router.Group("/api/v1")
	//ser up favicon route
	router.GET("/favicon.ico", func(c *gin.Context) {
		c.File("icons/favicon.ico")
	})

	//ROUTE GROUPS
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//unprotected routes
	routes.Pub_Media_routes(r.Group("/media"))

	//change goth auth route names to web auth
	routes.Web_Auth_routes(r.Group("/webAuth"))
	routes.Auth_routes(r.Group("/auth"))

	//protected routes
	routes.User_routes(r.Group("/users", SessionManager.AuthRequired()))
	routes.Media_routes(r.Group("/media", SessionManager.AuthRequired()))
	routes.Twilio_routes(r.Group("/twilio"))

	//development only routes
	routes.Dev_routes(r.Group("/dev"))

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
	defer TwilioManager.Disconnect()
}
