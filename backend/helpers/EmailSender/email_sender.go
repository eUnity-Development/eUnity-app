package EmailSender

import (
	"os"

	"github.com/joho/godotenv"
	"gopkg.in/gomail.v2"
)

// updated to nicer email sender with gomail package
func SendConfirmationEmail(to string) error {

	html, err := os.ReadFile("static/verifyEmail/inline.html")
	if err != nil {
		panic(err)
	}

	html_str := string(html)

	godotenv.Load()
	from := os.Getenv("EMAIL_ORIGIN")
	password := os.Getenv("EMAIL_PASSWORD")

	// Sender data.
	smtpHost := "smtp.office365.com"
	smtpPort := 587

	m := gomail.NewMessage()
	m.SetHeader("From", from)
	m.SetHeader("To", to)
	m.SetHeader("Subject", "Confirm your email address!")
	m.SetBody("text/html", html_str)

	d := gomail.NewDialer(smtpHost, smtpPort, from, password)

	// Send the email to Bob, Cora and Dan.
	if err := d.DialAndSend(m); err != nil {
		panic(err)
	}
	return nil
}

// func Send(to string) error {
// 	fmt.Println("Sending email to: ", to)
// 	fmt.Println("From: ", from)

// 	// Sender data.
// 	password := password
// 	smtpHost := "smtp.office365.com"
// 	smtpPort := 587

// 	m := gomail.NewMessage()
// 	m.SetHeader("From", from)
// 	m.SetHeader("To", to)
// 	// m.SetAddressHeader("Cc", "", "")
// 	m.SetHeader("Subject", "Hello!")
// 	m.SetBody("text/html", "Hello <b>Bob</b> and <i>Cora</i>!")
// 	//  m.SetBody("text/plain", "Hello Bob and Cora!")

// 	d := gomail.NewDialer(smtpHost, smtpPort, from, password)

// 	// Send the email to Bob, Cora and Dan.
// 	if err := d.DialAndSend(m); err != nil {
// 		panic(err)
// 	}
// 	return nil
// }
