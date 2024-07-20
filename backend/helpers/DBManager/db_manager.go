package DBManager

import (
	"context"
	"fmt"
	"os" // to access .env file
	"time"

	"github.com/joho/godotenv" // to load .env file
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var Host string // replaced the hardcoded database url with a variable, so we can load .env
var Client *mongo.Client
var DB *mongo.Database

func init() {
	godotenv.Load()                  //loads the .env file
	Host = os.Getenv("DATABASE_URL") //captures the database url from the .env file
	fmt.Println("Host:", Host)

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(Host))
	db := client.Database("eunity")
	if err != nil {
		fmt.Println("Error connecting to database")
		panic(err)
	}
	Client = client
	DB = db
}

func Disconnect() {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	if err := Client.Disconnect(ctx); err != nil {
		panic(err)
	}
}
