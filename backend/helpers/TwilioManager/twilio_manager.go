package TwilioManager

import (
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/twilio/twilio-go"
	api "github.com/twilio/twilio-go/rest/api/v2010"
	verify "github.com/twilio/twilio-go/rest/verify/v2"
)

var client *twilio.RestClient
var service_SID string

func init() {
	godotenv.Load()
	username := os.Getenv("TWILIO_ACCOUNT_SID")
	password := os.Getenv("TWILIO_AUTH_TOKEN")
	service_SID = os.Getenv("TWILIO_SERVICE_SID")

	client = twilio.NewRestClientWithParams(twilio.ClientParams{
		Username: username,
		Password: password,
	})
}

func Send_Message(to, from, body string) error {
	params := &api.CreateMessageParams{}
	params.SetTo(to)
	params.SetFrom(from)
	params.SetBody(body)

	_, err := client.Api.CreateMessage(params)
	return err
}

// using the verify API instead of the API API
func Send_Verification_Code(to string) error {
	params := &verify.CreateVerificationParams{}
	params.SetTo(to)
	params.SetChannel("sms")

	_, err := client.VerifyV2.CreateVerification(service_SID, params)
	if err != nil {
		return err
	}

	//print every param of resp objec
	return nil
}

func Verify_Code(to, code string) (bool, error) {
	params := &verify.CreateVerificationCheckParams{}
	params.SetTo(to)
	params.SetCode(code)

	resp, err := client.VerifyV2.CreateVerificationCheck(service_SID, params)
	if err != nil {
		return false, err
	}

	valid := *resp.Valid

	//print every param of resp objec

	return valid, nil
}

func Disconnect() {
	// Log the disconnection
	log.Println("Shutting down Twilio manager...")
	log.Println("Twilio manager shut down completed.")
}
