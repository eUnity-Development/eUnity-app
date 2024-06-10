package routes

import (
	"eunity.com/backend-main/controllers"
	"github.com/gin-gonic/gin"
)

var Twilio_controllers = controllers.Twilio_controllers{}

// TwilioRoutes sets up the routing for Twilio related functionality
func Twilio_routes(r *gin.RouterGroup) {
	r.POST("/send-sms", Twilio_controllers.Send_ver_sms)

	r.POST("/verify-phone", Twilio_controllers.Verify_phone)
}

// sendSMSHandler handles sending SMS messages
