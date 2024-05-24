package EmailSender

import (
	"crypto/tls"
	"errors"
	"fmt"
	"net/smtp"
	"os"
)

var origin = os.Getenv("EMAIL_ORIGIN")
var password = os.Getenv("EMAIL_PASSWORD")

func SendConfirmationEmail(email string) (string, error) {
	return "", nil
}

func Send(email string) error {
	// Sender data.
	from := origin

	// Receiver email address.
	to := []string{email}

	// SMTP server configuration.
	//smtpHost := "smtp-mail.outlook.com"
	smtpHost := "smtp.office365.com"
	smtpPort := "587"

	// Message.
	message := []byte("Subject: Test Email\n\nThis is a test email message.")

	// Authentication.
	auth := LoginAuth(origin, password)

	// TLS configuration.
	tlsConfig := &tls.Config{
		InsecureSkipVerify: true, // Change this to false in production
		ServerName:         smtpHost,
	}

	// SMTP client with TLS configuration.
	client, err := smtp.Dial(smtpHost + ":" + smtpPort)
	if err != nil {
		return err
	}
	defer client.Close()

	if err = client.StartTLS(tlsConfig); err != nil {
		return err
	}

	// Authentication.
	if err = client.Auth(auth); err != nil {
		return err
	}

	// Set sender and recipient.
	if err = client.Mail(from); err != nil {
		return err
	}
	for _, addr := range to {
		if err = client.Rcpt(addr); err != nil {
			return err
		}
	}

	// Send email body.
	wc, err := client.Data()
	if err != nil {
		return err
	}
	_, err = wc.Write(message)
	if err != nil {
		return err
	}
	err = wc.Close()
	if err != nil {
		return err
	}

	fmt.Println("Email Sent Successfully!")
	return nil
}

type loginAuth struct {
	username, password string
}

func LoginAuth(username, password string) smtp.Auth {
	return &loginAuth{username, password}
}

func (a *loginAuth) Start(server *smtp.ServerInfo) (string, []byte, error) {
	return "LOGIN", []byte{}, nil
}

func (a *loginAuth) Next(fromServer []byte, more bool) ([]byte, error) {
	if more {
		switch string(fromServer) {
		case "Username:":
			return []byte(a.username), nil
		case "Password:":
			return []byte(a.password), nil
		default:
			return nil, errors.New("Unkown fromServer")
		}
	}
	return nil, nil
}
