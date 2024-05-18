package main

import (
	"fmt"
	"net/http"

	docs "eunity.com/backend-main/docs"
	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/routes"
	"github.com/gin-gonic/gin"
	swaggerfiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	"github.com/twilio/twilio-go"
	verify "github.com/twilio/twilio-go/rest/verify/v2"
)

func main() {

	//init server
	router := gin.Default()

	//init DbManager
	DBManager.Init()

	//set default endpoint
	docs.SwaggerInfo.BasePath = "/api/v1"
	r := router.Group("/api/v1")
	//ROUTE GROUPS
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//set up routes
	routes.User_routes(r.Group("/users"))

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
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Verification with SMS (Twilio)
	client := twilio.NewRestClient()
	params := &verify.CreateVerificationParams{}
	params.SetTo("+15017122661")
	params.SetChannel("sms")
	resp, err := client.VerifyV2.CreateVerification("VA2326c9409694c660f36071c87130b379", params)
	if err != nil {
		fmt.Println(err.Error())
	} else {
		if resp.Status != nil {
			fmt.Println(*resp.Status)
		} else {
			fmt.Println(resp.Status)
		}
	}
}
