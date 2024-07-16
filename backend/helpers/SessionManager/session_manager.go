package SessionManager

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"github.com/google/uuid"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/bson"
)

// retrieves session data using the session_id stored in the cookies
var ValKey bool
var rdb *redis.Client
var ctx = context.Background()

// https only must be true in production
var HTTPS_only bool

// must be set to eunityusa.com in production
var Cookie_Host string

func init() {
	godotenv.Load()
	godotenv.Load()
	HTTPS_only = os.Getenv("HTTPS_ONLY") == "true"
	Cookie_Host = os.Getenv("COOKIE_ACCEPT_HOST")
	valkey := os.Getenv("VALKEY_ENABLED")
	if valkey == "true" {
		ValKey = true
		rdb = redis.NewClient(&redis.Options{
			Addr:     "localhost:6379",
			Password: "123456", // no password set
			DB:       0,        // use default DB
		})

		_, err := rdb.Ping(ctx).Result()
		if err != nil {
			fmt.Println("Error connecting to Valkey")
			ValKey = false
		}
	} else {
		ValKey = false
	}
}

func Get_Session(session_id string) (models.Session, error) {
	switch ValKey {
	case true:
		//get session id from valkey
		session, err := rdb.Get(ctx, session_id).Result()
		if err != nil {
			return models.Session{}, err
		}
		var sessionData models.Session
		err = json.Unmarshal([]byte(session), &sessionData)
		if err != nil {
			return models.Session{}, err
		}
		return sessionData, nil
	default:
		//get session id from mongo db
		session := DBManager.DB.Collection("session_ids").FindOne(context.Background(), bson.M{"session_id": session_id})
		if session.Err() != nil {
			return models.Session{}, session.Err()
		}

		//get session data
		var sessionData models.Session
		err := session.Decode(&sessionData)
		if err != nil {
			return models.Session{}, err
		}
		return sessionData, nil
	}
}

func Create_Session(user_id string, c *gin.Context) (models.Session, error) {
	cookie_max_age := 365 * 24 * 60 * 60 //1 year
	session := models.Session{
		Session_id: uuid.New().String(),
		Created_at: time.Now().Unix(),
		//we don't deny access if expired we just rotate session_ids
		Expires_at:  time.Now().Unix() + 3600*6, //6 hours
		User_id:     user_id,
		Permissions: []string{"user"}, //default permissions
	}
	jsonSession, err := json.Marshal(session)
	if err != nil {
		return session, err
	}
	switch ValKey {
	case true:
		fmt.Println("Creating session in Valkey")
		//add session to Valkey as map from session_id to session in json
		err = rdb.Set(ctx, session.Session_id, jsonSession, 0).Err()
		if err != nil {
			return session, err
		}

		c.SetCookie("session_id", session.Session_id, cookie_max_age, "/", Cookie_Host, HTTPS_only, true)
		return session, nil

	default:
		//create session id in mongo db
		_, err = DBManager.DB.Collection("session_ids").InsertOne(context.Background(), session)
		if err != nil {
			return session, err
		}
		c.SetCookie("session_id", session.Session_id, cookie_max_age, "/", Cookie_Host, HTTPS_only, true)
		return session, nil
	}

}

func Create_Developer_Session(user_id string, c *gin.Context) (models.Session, error) {
	cookie_max_age := 365 * 24 * 60 * 60 //1 year
	session := models.Session{
		Session_id: uuid.New().String(),
		Created_at: time.Now().Unix(),
		//we don't deny access if expired we just rotate session_ids
		Expires_at:  time.Now().Unix() + 3600*6, //6 hours
		User_id:     user_id,
		Permissions: []string{"developer"}, //default permissions
	}
	jsonSession, err := json.Marshal(session)
	if err != nil {
		return session, err
	}
	switch ValKey {
	case true:
		fmt.Println("Creating session in Valkey")
		//add session to Valkey as map from session_id to session in json
		err = rdb.Set(ctx, session.Session_id, jsonSession, 0).Err()
		if err != nil {
			return session, err
		}

		c.SetCookie("session_id", session.Session_id, cookie_max_age, "/", Cookie_Host, HTTPS_only, true)
		return session, nil

	default:
		//create session id in mongo db
		_, err = DBManager.DB.Collection("session_ids").InsertOne(context.Background(), session)
		if err != nil {
			return session, err
		}
		c.SetCookie("session_id", session.Session_id, cookie_max_age, "/", Cookie_Host, HTTPS_only, true)
		return session, nil
	}

}

func Delete_Session(session_id string) error {
	switch ValKey {
	case true:
		//delete session from valkey
		_, err := rdb.Del(ctx, session_id).Result()
		if err != nil {
			return err
		}
		return nil
	default:
		//delete session from mongo db
		_, err := DBManager.DB.Collection("session_ids").DeleteOne(context.Background(), bson.M{session_id: bson.M{"$exists": true}})
		if err != nil {
			return err
		}
		return nil
	}
}

func AuthRequired() gin.HandlerFunc {
	return func(c *gin.Context) {

		//must change this to domain name in production
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")

		//check cookies
		session_id, err := c.Cookie("session_id")
		if err != nil {
			c.JSON(401, gin.H{
				"response": "Unauthorized",
			})
			c.Abort()
			return
		}

		switch ValKey {
		case true:

			//check if session_id exists in valkey
			session, err := Get_Session(session_id)
			if err != nil {
				c.JSON(401, gin.H{
					"response": "Unauthorized",
				})
				c.Abort()
				return
			}

			expires_at := time.Unix(session.Expires_at, 0)

			if time.Now().After(expires_at) {
				old_session_id := session.Session_id
				session, err = Create_Session(session.User_id, c)
				if err != nil {
					c.JSON(500, gin.H{
						"response": "Error creating session",
					})
					c.Abort()
					return
				}

				//delete old session
				err = Delete_Session(old_session_id)
				if err != nil {
					c.JSON(500, gin.H{
						"response": "Error rotating old session",
					})
					c.Abort()
					return
				}

			}

			//set all session data in c keys for easy access
			c.Set("session_id", session.Session_id)
			c.Set("created_at", session.Created_at)
			c.Set("expires_at", session.Expires_at)
			c.Set("user_id", session.User_id)
			c.Set("permissions", session.Permissions)

			return

		default:
			//check if session_id exists in session_ids collection
			session, err := Get_Session(session_id)
			if err != nil {
				c.JSON(401, gin.H{
					"response": "Unauthorized",
				})
				c.Abort()
				return
			}

			//check if session is expired
			expires_at := time.Unix(session.Expires_at, 0)

			if time.Now().After(expires_at) {
				old_session_id := session.Session_id
				session, err = Create_Session(session.User_id, c)
				if err != nil {
					c.JSON(500, gin.H{
						"response": "Error creating session",
					})
					c.Abort()
					return
				}

				//delete old session
				err = Delete_Session(old_session_id)
				if err != nil {
					c.JSON(500, gin.H{
						"response": "Error rotating old session",
					})
					c.Abort()
					return
				}
			}

			//set all session data in c keys for easy access
			c.Set("session_id", session.Session_id)
			c.Set("created_at", session.Created_at)
			c.Set("expires_at", session.Expires_at)
			c.Set("user_id", session.User_id)
			c.Set("permissions", session.Permissions)
			c.Next()
		}
		c.Next()
	}
}
