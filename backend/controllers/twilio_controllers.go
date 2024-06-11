package controllers

import (
	"fmt"
	"net/http"

	"eunity.com/backend-main/helpers/TwilioManager"
	"github.com/gin-gonic/gin"
)

type Twilio_controllers struct {
}

// @Summary Send SMS
// @Description Send an SMS message
// @Tags Twilio
// @Accept  json
// @Produce  json
// @Param to query string true "Recipient phone number"
// @Param body query string true "Message body"
// @Success 200 {string} string "SMS sent successfully!"
// @Router /twilio/send-sms [post]
func (tc *Twilio_controllers) Send_ver_sms(c *gin.Context) {

	to := c.Query("to")
	body := c.Query("body")
	// from := "+17162721672"

	fmt.Println("to: ", to)
	fmt.Println("body: ", body)

	// err := TwilioManager.SendMessage(to, from, body)
	// if err != nil {
	// 	c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	// 	return
	// }

	err := TwilioManager.Send_Verification_Code(to)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "SMS sent successfully!"})
}

// @Summary Verify Phone Number
// @Description Verify a phone number
// @Tags Twilio
// @Accept  json
// @Produce  json
// @Param to query string true "Recipient phone number"
// @Param code query string true "Verification code"
// @Success 200 {string} string "Phone number verified successfully!"
// @Router /twilio/verify-phone [post]
func (tc *Twilio_controllers) Verify_phone(c *gin.Context) {

	to := c.Query("to")
	code := c.Query("code")

	fmt.Println("to: ", to)
	fmt.Println("code: ", code)

	valid, err := TwilioManager.Verify_Code(to, code)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error(), "message": "make sure to add +1 to the phone number format --> +1xxxxxxxxxx"})
		return
	}

	if !valid {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Invalid verification code!"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Phone number verified successfully!"})
}
