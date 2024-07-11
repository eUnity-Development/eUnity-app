package controllers

import (
	"context"
	"fmt"
	"reflect"
	"regexp"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/helpers/PasswordHasher"
	"eunity.com/backend-main/helpers/SessionManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

//load env

// create empty struct to attach methods touser
type User_controllers struct {
}

// @Summary User test route
// @Schemes
// @Description returns a string from user routes
// @Tags User
// @Accept json
// @Produce json
// @Success 200 {string} Hello from user routes
// @Router /users/me [get]
func (u *User_controllers) GET_me(c *gin.Context) {

	user_id := c.Keys["user_id"].(string)

	//turn string id into bson object id
	bson_user_id, err := primitive.ObjectIDFromHex(user_id)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Invalid user ID",
		})
		return
	}

	user := DBManager.DB.Collection("users").FindOne(context.Background(), bson.M{"_id": bson_user_id})
	if user.Err() != nil {
		c.JSON(400, gin.H{
			"response": "No user found",
		})
		return
	}

	result := models.User{}
	err = user.Decode(&result)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "No user found",
		})
		return
	}

	c.JSON(200, result)
}

// @Summary User update route
// @Schemes
// @Description takes in a json object and attempts to update the user, does not modify base fields such as email, it is a protected route
// @Tags User
// @Accept json
// @Produce json
// @Param data body string true "Data"
// @Success 200 {string} User updated
// @Success 400 {string} Unable to update user
// @Router /users/me [patch]
func (u *User_controllers) PATCH_me(c *gin.Context) {
	//get body
	user := models.User{}
	err := c.BindJSON(&user)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to update user 1",
		})
		return
	}

	//get user id
	user_id := c.Keys["user_id"].(string)

	// //turn string id into bson object id
	bson_user_id, err := primitive.ObjectIDFromHex(user_id)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Invalid user ID",
		})
		return
	}

	// user_copy := user

	//get values and types from user object
	v := reflect.ValueOf(user)
	typeOfUser := v.Type()
	for i := 0; i < v.NumField(); i++ {
		// Get the bson tag of the field
		bsonTag := typeOfUser.Field(i).Tag.Get("bson")

		// If the bson tag is "-", the field is ignored
		if bsonTag == "-" {
			continue
		}

		// If the bson tag is not empty, use it as the key
		key := bsonTag
		if key == "" {
			// If the bson tag is empty, use the field name as the key
			key = typeOfUser.Field(i).Name
		}

		value := v.Field(i)
		//check if nill
		if (value.Kind() == reflect.Ptr || value.Kind() == reflect.Slice || value.Kind() == reflect.Map || value.Kind() == reflect.Interface || value.Kind() == reflect.Chan || value.Kind() == reflect.Func) && value.IsNil() {
			continue
		}

		if (value.Kind() == reflect.Slice || value.Kind() == reflect.Array || value.Kind() == reflect.String) && value.Len() == 0 {
			// Handle the case where the value is empty
			continue
		} else {
			_, err = DBManager.DB.Collection("users").UpdateOne(context.Background(), bson.M{"_id": bson_user_id}, bson.M{"$set": bson.M{key: value.Interface()}})
			if err != nil {
				c.JSON(400, gin.H{
					"response": "Unable to update user 2",
				})
				return
			}
		}
	}

	c.JSON(200, gin.H{
		"response": "User updated",
	})

}

// @Summary User logout route
// @Schemes
// @Description logs out a user
// @Tags User
// @Accept mpfd
// @Produce json
// @Success 200 {string} Logged out
// @Success 400 {string} Unable to logout
// @Router /users/logout [post]
func (u *User_controllers) POST_logout(c *gin.Context) {
	session_id, err := c.Cookie("session_id")
	if err != nil {
		c.JSON(400, gin.H{
			"response": "No session found",
		})
		return
	}

	_, err = DBManager.DB.Collection("session_ids").DeleteOne(context.Background(), bson.M{session_id: bson.M{"$exists": true}})
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to logout",
		})
		return
	}

	//remove cookies
	c.SetCookie("session_id", "", -1, "/", SessionManager.Cookie_Host, SessionManager.HTTPS_only, true)

	c.JSON(200, gin.H{
		"response": "Logged out",
	})
}

// @Summary User signup route
// @Schemes
// @Description creates a new user
// @Tags Public User
// @Accept mpfd
// @Produce json
// @Param email formData string true "Email"
// @Param password formData string true "Password"
// @Success 200 {string} Please verify your email
// @Success 400 {string} Unable to create account
// @Success 400 {string} Account with this email, already exists
// @Router /users/signup [post]
func (u *User_controllers) POST_signup(c *gin.Context) {
	var credentials models.User
	err := c.Bind(&credentials)
	if err != nil {
		fmt.Println(err)
		c.JSON(400, gin.H{
			"response": "Unable to create account",
		})
		return

	}

	//check password against regex
	uppercase := "[A-Z]"
	lowercase := "[a-z]"
	number := "\\d"
	minLength := ".{8,}"
	matchUpper, _ := regexp.MatchString(uppercase, credentials.Password)
	matchLower, _ := regexp.MatchString(lowercase, credentials.Password)
	matchNumber, _ := regexp.MatchString(number, credentials.Password)
	matchLength, _ := regexp.MatchString(minLength, credentials.Password)
	if !matchUpper || !matchLower || !matchNumber || !matchLength {
		fmt.Println(matchLength, matchLower, matchNumber, matchUpper, credentials.Password)
		c.JSON(400, gin.H{
			"response": "Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number and be at least 8 characters long",
		})
		return
	}

	//check if the user already exists
	user := DBManager.DB.Collection("users").FindOne(context.Background(), bson.M{"email": credentials.Email})
	if user.Err() == nil {
		// check if password is correct
		var result models.User
		err := user.Decode(&result)
		if err != nil {
			c.JSON(400, gin.H{
				"response": err.Error(),
			})
			return
		}
		passwordHash := result.PasswordHash
		if PasswordHasher.Check_Password(credentials.Password, passwordHash) {
			c.JSON(400, gin.H{
				"response": "Account with this email, already exists",
			})
			return
		}
		c.JSON(400, gin.H{
			"response": "Unable to create account 2",
		})
		return
	}

	//hash the password
	password_hash, err := PasswordHasher.Hash_Password(credentials.Password)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to create account 3",
		})
		return
	}

	//we do not store the users password in the database
	objectID := primitive.NewObjectID()
	default_match_preferences := models.MatchPreferences{
		Genders:           []string{},
		RelationshipTypes: []string{},
		MinimumAge:        18,
		MaximumAge:        32,
		MaximumDistance:   25,
	}

	new_user := models.User{
		ID:                    &objectID,
		Email:                 credentials.Email,
		PasswordHash:          password_hash,
		Verified_email:        false,
		Verified_phone_number: false,
		IsProfileSetUp:        false,
		MediaFiles:            []string{},
		Providers:             make(map[string]models.Provider),
		MatchPreferences:      default_match_preferences,
	}

	_, err = DBManager.DB.Collection("users").InsertOne(context.Background(), new_user)
	if err != nil {
		fmt.Println(err)
		c.JSON(400, gin.H{
			"response": "Unable to create user",
		})
		return
	}

	c.JSON(200, gin.H{
		"response": "Successfully created account, please verify email",
	})
}

// @Summary User login route
// @Schemes
// @Description logs in a user
// @Tags Public User
// @Accept mpfd
// @Produce json
// @Param email formData string true "Email"
// @Param password formData string true "Password"
// @Success 200 {string} Logged in
// @Success 400 {string} Unable to login
// @Success 400 {string} Account not found
// @Success 400 {string} Incorrect password
// @Router /users/login [post]
func (u *User_controllers) POST_login(c *gin.Context) {
	var credentials models.User
	err := c.Bind(&credentials)
	if err != nil {
		fmt.Println(err)
		c.JSON(400, gin.H{
			"response": "Unable to login",
		})
		return

	}

	//check if the user exists
	user := DBManager.DB.Collection("users").FindOne(context.Background(), bson.M{"email": credentials.Email})
	if user.Err() != nil {
		c.JSON(400, gin.H{
			"response": "Account not found",
		})
		return
	}
	// check if password is correct
	var result models.User
	err = user.Decode(&result)

	if err != nil {
		c.JSON(400, gin.H{
			"response": err.Error(),
		})
		return
	}

	passwordHash := result.PasswordHash
	if !PasswordHasher.Check_Password(credentials.Password, passwordHash) {
		c.JSON(400, gin.H{
			"response": "Incorrect password",
		})
		return
	}

	//check if account is verified/ email is verified
	// if !result.Verified {
	// 	c.JSON(400, gin.H{
	// 		"response": "Account not verified",
	// 	})
	// 	return
	// }

	//check if the user is already logged in
	session_id, err := c.Cookie("session_id")
	if err == nil {
		session := DBManager.DB.Collection("session_ids").FindOne(context.Background(), bson.M{session_id: bson.M{"$exists": true}})

		if session.Err() == nil {
			c.JSON(400, gin.H{
				"response": "Already logged in",
			})
			return

		}
	}

	//create a new session
	_, err = SessionManager.Create_Session(result.ID.Hex(), c)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to login",
		})
		return

	}

	c.JSON(200, gin.H{
		"response": "Logged in",
	})
}

// @Summary User test route
// @Schemes
// @Description returns a string from user routes
// @Tags User
// @Accept json
// @Produce json
// @Success 200 {string} Hello from user routes
// @Router /users/Testing_Context [get]
func (u *User_controllers) Testing_Context(c *gin.Context) {
	session_id := c.Keys["session_id"]
	user_id := c.Keys["user_id"]

	c.JSON(200, gin.H{
		"session_id":  session_id,
		"user_id":     user_id,
		"expires_at":  c.Keys["expires_at"],
		"created_at":  c.Keys["created_at"],
		"permissions": c.Keys["permissions"],
	})
}
