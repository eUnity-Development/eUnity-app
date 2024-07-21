package main

import (
	"context"
	"fmt"
	"os"

	"github.com/go-redis/redis/v8"
	"github.com/joho/godotenv"
)

var ValKey bool
var rdb *redis.Client
var ctx = context.Background()

// https only must be true in production
var HTTPS_only bool

// must be set to eunityusa.com in production
var Cookie_Host string

func main() {
	godotenv.Load()
	valkey_url := os.Getenv("VALKEY_URL")
	valkey_pass := os.Getenv("VALKEY_PASS")

	rdb = redis.NewClient(&redis.Options{
		Addr:     valkey_url,
		Password: valkey_pass, // no password set
		DB:       0,           // use default DB
	})

	_, err := rdb.Ping(ctx).Result()
	if err != nil {
		fmt.Println("Error connecting to Valkey")
		ValKey = false
	}

	err = rdb.Set(ctx, "session_id", "123456", 0).Err()
	if err != nil {
		panic(err)
	}

	val, err := rdb.Get(ctx, "session_id").Result()
	if err != nil {
		fmt.Println("Error getting session_id:", err)
	}

	fmt.Println("session_id:", val)

}
