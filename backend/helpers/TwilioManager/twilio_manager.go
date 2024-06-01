package TwilioManager

import (
	"log"
	"os"

	"github.com/twilio/twilio-go"
	api "github.com/twilio/twilio-go/rest/api/v2010"
)

var client *twilio.RestClient

func Init() {
	client = twilio.NewRestClientWithParams(twilio.ClientParams{
		Username: os.Getenv("TWILIO_ACCOUNT_SID"),
		Password: os.Getenv("TWILIO_AUTH_TOKEN"),
	})
}

func SendMessage(to, from, body string) error {
	params := &api.CreateMessageParams{}
	params.SetTo(to)
	params.SetFrom(from)
	params.SetBody(body)

	_, err := client.Api.CreateMessage(params)
	return err
}

func Disconnect() {
	// Log the disconnection
	log.Println("Shutting down Twilio manager...")
	log.Println("Twilio manager shut down completed.")
}
