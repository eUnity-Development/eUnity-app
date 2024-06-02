package EmailSender

import (
	"bytes"
	"html/template"
	"log"
	"os"

	"github.com/joho/godotenv"
	"gopkg.in/gomail.v2"
)

// updated to nicer email sender with gomail package
func SendConfirmationEmail(to string) error {

	godotenv.Load()
	from := os.Getenv("EMAIL_ORIGIN")
	password := os.Getenv("EMAIL_PASSWORD")

	//getting the html template
	html, err := os.ReadFile("static/verifyEmail/inline.html")
	if err != nil {
		panic(err)
	}

	// Parse the template
	t, err := template.New("inline").Parse(string(html))
	if err != nil {
		panic(err)
	}

	// Data to be passed to the template
	data := struct {
		Verification_url string
		Support_email    string
	}{
		Verification_url: "https://random.dog/",
		Support_email:    from,
	}

	// Execute the templat -- pass the data to the template
	var tpl bytes.Buffer
	if err := t.Execute(&tpl, data); err != nil {
		log.Println(err)
	}

	//Turn the template into a string
	result := tpl.String()

	// Sender data.
	smtpHost := "smtp.office365.com"
	smtpPort := 587

	m := gomail.NewMessage()
	m.SetHeader("From", from)
	m.SetHeader("To", to)
	m.SetHeader("Subject", "Confirm your email address!")
	m.SetBody("text/html", result)

	d := gomail.NewDialer(smtpHost, smtpPort, from, password)

	// Send confirmation email
	if err := d.DialAndSend(m); err != nil {
		panic(err)
	}
	return nil
}
