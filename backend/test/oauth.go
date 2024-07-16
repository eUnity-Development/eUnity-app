package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/google"
)

type Config struct {
	GoogleLoginConfig oauth2.Config
}

var AppConfig Config

func GoogleConfig() oauth2.Config {
	godotenv.Load()
	client_id := os.Getenv("GOOGLE_KEY")
	client_secret := os.Getenv("GOOGLE_SECRET")
	fmt.Println("here")
	fmt.Println(client_id)
	fmt.Println(client_secret)

	AppConfig.GoogleLoginConfig = oauth2.Config{
		//RedirectURL:  "http://localhost:8080/google_callback",
		ClientID:     os.Getenv("GOOGLE_KEY"),
		ClientSecret: os.Getenv("GOOGLE_SECRET"),
		Scopes: []string{"https://www.googleapis.com/auth/userinfo.email",
			"https://www.googleapis.com/auth/userinfo.profile"},
		Endpoint: google.Endpoint,
	}

	return AppConfig.GoogleLoginConfig
}

func main() {
	googlecon := GoogleConfig()
	code := "4/0AdLIrYelx_wzSsJpGpBvdaGvniao7AGhF48Kpn7kum6JiPxIRbrWu_ApSOcrrOrWEnWurw"
	token, err := googlecon.Exchange(context.Background(), code)
	if err != nil {
		log.Fatalf("An error occured while exchanging the code. Err: %s", err)
	}

	fmt.Println(token)
}
