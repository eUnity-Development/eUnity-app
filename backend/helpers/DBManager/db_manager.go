package DBManager

import (
	"context"
	"os"
	"time"

	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

// must replace default db and host using .env variables
var Host string
var Client *mongo.Client
var DB *mongo.Database

func Init() {
	godotenv.Load()
	Host = os.Getenv("DATABASE_URL")
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(Host))
	db := client.Database("eunity")
	if err != nil {
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
