package routes

import (
	"net/http"

	"eunity.com/backend-main/helpers/TwilioManager"
	"github.com/gin-gonic/gin"
)

// TwilioRoutes sets up the routing for Twilio related functionality
func TwilioRoutes(rg *gin.RouterGroup) {
	rg.POST("/send-sms", sendSMSHandler)
}

// sendSMSHandler handles sending SMS messages
func sendSMSHandler(c *gin.Context) {
	type smsRequest struct {
		To   string `json:"to" binding:"required"`
		From string `json:"from" binding:"required"`
		Body string `json:"body" binding:"required"`
	}

	var req smsRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request parameters"})
		return
	}

	err := TwilioManager.SendMessage(req.To, req.From, req.Body)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to send SMS", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "SMS sent successfully!"})
}
