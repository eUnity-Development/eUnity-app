package EmailSender

import (
	"fmt"
	"html/template"
	"io"
	"os"

	"github.com/joho/godotenv"
	"gopkg.in/gomail.v2"
)

func SendConfirmationEmail(email string) (string, error) {
	return "", nil
}

// updated to nicer email sender with gomail package
func Send(to string) error {
	godotenv.Load()
	from := os.Getenv("EMAIL_ORIGIN")
	password := os.Getenv("EMAIL_PASSWORD")
	fmt.Println("Sending email to: ", to)
	fmt.Println("From: ", from)

	// Sender data.
	smtpHost := "smtp.office365.com"
	smtpPort := 587

	m := gomail.NewMessage()
	m.SetHeader("From", from)
	m.SetHeader("To", to)
	m.SetAddressHeader("Cc", "", "")
	m.SetHeader("Subject", "Hello!")
	//m.SetBody("text/html", "Hello <b>Bob</b> and <i>Cora</i>!")
	//  m.SetBody("text/plain", "Hello Bob and Cora!")
	m.Attach("template.html")

	t, _ := template.ParseFiles("template.html")
	m.AddAlternativeWriter("text/html", func(w io.Writer) error {
		return t.Execute(w, struct {
			Name    string
			Message string
		}{
			Name:    "Batman",
			Message: "This is a test message in a HTML template",
		})
	})

	d := gomail.NewDialer(smtpHost, smtpPort, from, password)

	// Send the email to Bob, Cora and Dan.
	if err := d.DialAndSend(m); err != nil {
		panic(err)
	}
	return nil
}

//I'm code hoarding because I haven't gotten email sender to work since smtp is still blocked
//will make random gmail account if bug goes on for too long

// func Send(email string) error {
// 	godotenv.Load()
// 	var origin = os.Getenv("EMAIL_ORIGIN")
// 	var password = os.Getenv("EMAIL_PASSWORD")
// 	fmt.Println("Email: ", email)
// 	fmt.Println("Origin: ", origin)
// 	fmt.Println("Password: ", password)

// 	fmt.Println("Trying to send email")

// 	// Sender data.
// 	from := origin

// 	// Receiver email address.
// 	to := []string{email}

// 	// SMTP server configuration.
// 	smtpHost := "smtp-mail.outlook.com"
// 	//smtpHost := "smtp.office365.com"
// 	smtpPort := "587"

// 	// Message.
// 	message := []byte("Subject: Test Email\n\nThis is a test email message.")

// 	// Authentication.
// 	auth := LoginAuth(origin, password)

// 	// TLS configuration.
// 	tlsConfig := &tls.Config{
// 		InsecureSkipVerify: true, // Change this to false in production
// 		ServerName:         smtpHost,
// 	}

// 	// SMTP client with TLS configuration.
// 	client, err := smtp.Dial(smtpHost + ":" + smtpPort)
// 	if err != nil {
// 		return err
// 	}
// 	defer client.Close()

// 	if err = client.StartTLS(tlsConfig); err != nil {
// 		return err
// 	}

// 	// Authentication.
// 	if err = client.Auth(auth); err != nil {
// 		return err
// 	}

// 	// Set sender and recipient.
// 	if err = client.Mail(from); err != nil {
// 		return err
// 	}
// 	for _, addr := range to {
// 		if err = client.Rcpt(addr); err != nil {
// 			return err
// 		}
// 	}

// 	// Send email body.
// 	wc, err := client.Data()
// 	if err != nil {
// 		return err
// 	}
// 	_, err = wc.Write(message)
// 	if err != nil {
// 		return err
// 	}
// 	err = wc.Close()
// 	if err != nil {
// 		return err
// 	}

// 	fmt.Println("Email Sent Successfully!")
// 	return nil
// }

// type loginAuth struct {
// 	username, password string
// }

// func LoginAuth(username, password string) smtp.Auth {
// 	return &loginAuth{username, password}
// }

// func (a *loginAuth) Start(server *smtp.ServerInfo) (string, []byte, error) {
// 	return "LOGIN", []byte{}, nil
// }

// func (a *loginAuth) Next(fromServer []byte, more bool) ([]byte, error) {
// 	if more {
// 		switch string(fromServer) {
// 		case "Username:":
// 			return []byte(a.username), nil
// 		case "Password:":
// 			return []byte(a.password), nil
// 		default:
// 			return nil, errors.New("Unkown fromServer")
// 		}
// 	}
// 	return nil, nil
// }
