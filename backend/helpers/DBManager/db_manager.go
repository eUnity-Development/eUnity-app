package DBManager

import (
	"context"
	"time"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

// must replace default db and host using .env variables
var Host = "mongodb+srv://edstone:2renXmKIREOhXSzr@eunitybe.u8ityhz.mongodb.net/"
var Client *mongo.Client
var DB *mongo.Database

func Init() {

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
