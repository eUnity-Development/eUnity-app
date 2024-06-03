package main

import (
	"context"
	"fmt"
	"net/http"
	"time"

	docs "eunity.com/backend-main/docs"
	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/routes"
	"github.com/gin-gonic/gin"
	swaggerfiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	"go.mongodb.org/mongo-driver/bson"
)

func main() {

	//init server
	router := gin.Default()

	//init DbManager
	DBManager.Init()

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
	routes.Pub_User_routes(r.Group("/users"))
	routes.Pub_Media_routes(r.Group("/media"))
	routes.Auth_routes(r.Group("/auth"))

	//protected routes
	routes.User_routes(r.Group("/users", AuthRequired()))
	routes.Media_routes(r.Group("/media", AuthRequired()))

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

func AuthRequired() gin.HandlerFunc {
	fmt.Print("AuthRequired")
	return func(c *gin.Context) {
		//check cookies
		session_id, err := c.Cookie("session_id")
		if err != nil {
			c.JSON(401, gin.H{
				"response": "Unauthorized",
			})
			c.Abort()
			return
		}

		expiry, err := c.Cookie("expires_at")
		if err != nil {
			c.JSON(401, gin.H{
				"response": "Unauthorized",
			})
			c.Abort()
			return
		}
		//check if expired
		if expiry < time.Now().String() {
			c.JSON(401, gin.H{
				"response": "Unauthorized",
			})
			c.Abort()
			return
		}

		//check if session_id exists in session_ids collection
		session := DBManager.DB.Collection("session_ids").FindOne(context.Background(), bson.M{session_id: bson.M{"$exists": true}})
		if session.Err() != nil {
			c.JSON(401, gin.H{
				"response": "Unauthorized",
			})
			c.Abort()
			return
		}
		c.Next()
	}
}
