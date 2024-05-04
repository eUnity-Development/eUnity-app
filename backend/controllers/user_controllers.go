package controllers

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"regexp"
	"time"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/helpers/PasswordHasher"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
)

// create empty struct to attach methods to
type User_controllers struct {
}

// @Summary User test route
// @Schemes
// @Description returns a string from user routes
// @Tags example
// @Accept json
// @Produce json
// @Success 200 {string} Hello from user routes
// @Router /users/me [get]
func (u *User_controllers) GET_me(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "Hello from user routes",
	})
}

// @Summary User signup route
// @Schemes
// @Description creates a new user
// @Tags example
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
	fmt.Println(user)
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
		if PasswordHasher.CheckPassword(credentials.Password, passwordHash) {
			c.JSON(400, gin.H{
				"response": "Account with this email, already exists",
			})
			return
		}
		c.JSON(400, gin.H{
			"response": "Unable to create account 2",
		})

	}

	//hash the password
	password_hash, err := PasswordHasher.HashPassword(credentials.Password)
	if err != nil {
		c.JSON(400, gin.H{
			"response": "Unable to create account 3",
		})
		return
	}

	//we do not store the users password in the database
	new_user := models.User{
		Email:        credentials.Email,
		PasswordHash: password_hash,
		Verified:     false,
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
// @Tags example
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
	if !PasswordHasher.CheckPassword(credentials.Password, passwordHash) {
		c.JSON(400, gin.H{
			"response": "Incorrect password",
		})
		return
	}

	//check if account is verified
	// if !result.Verified {
	// 	c.JSON(400, gin.H{
	// 		"response": "Account not verified",
	// 	})
	// 	return
	// }

	cookie := generate_secure_cookie(result)

	//set cookie
	c.SetCookie("session", cookie["session_id"].(string), 3600, "/", "localhost", false, true)
	c.SetCookie("user_id", cookie["user_id"].(string), 3600, "/", "localhost", false, true)
	c.SetCookie("expires", cookie["expires"].(string), 3600, "/", "localhost", false, true)

	c.JSON(200, gin.H{
		"response": "Logged in",
	})
}

func generate_secure_cookie(user models.User) gin.H {
	now := time.Now()
	expires := now.AddDate(0, 0, 7)

	expires_string := expires.Format(time.RFC1123)

	cookie := gin.H{
		"user_id":    user.ID,
		"session_id": generate_secure_token(32),
		"expires":    expires_string,
	}
	return cookie
}

func generate_secure_token(length int) string {
	b := make([]byte, length)
	if _, err := rand.Read(b); err != nil {
		return ""
	}
	return hex.EncodeToString(b)
}
