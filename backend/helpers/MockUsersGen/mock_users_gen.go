package MockUsersGen

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func get_random_user() (models.User, error) {
	// URL of the API endpoint
	url := "https://randomuser.me/api/"

	// Make a GET request to the endpoint
	resp, err := http.Get(url)
	if err != nil {
		log.Fatalf("Error making GET request: %v", err)
	}
	defer resp.Body.Close()

	// Check the response status code
	if resp.StatusCode != http.StatusOK {
		log.Fatalf("Error: Unexpected status code %d", resp.StatusCode)
	}

	// Decode the JSON response
	var data map[string]interface{}
	err = json.NewDecoder(resp.Body).Decode(&data)
	if err != nil {
		log.Fatalf("Error decoding JSON: %v", err)
	}

	// Print out the results
	fmt.Println("Random User API Response:")
	fmt.Println("-------------------------")
	fmt.Printf("Gender: %s\n", data["results"].([]interface{})[0].(map[string]interface{})["gender"])
	fmt.Printf("Name: %s %s\n", data["results"].([]interface{})[0].(map[string]interface{})["name"].(map[string]interface{})["first"], data["results"].([]interface{})[0].(map[string]interface{})["name"].(map[string]interface{})["last"])
	fmt.Printf("Location: %s, %s, %s\n", data["results"].([]interface{})[0].(map[string]interface{})["location"].(map[string]interface{})["street"], data["results"].([]interface{})[0].(map[string]interface{})["location"].(map[string]interface{})["city"], data["results"].([]interface{})[0].(map[string]interface{})["location"].(map[string]interface{})["country"])
	fmt.Printf("Email: %s\n", data["results"].([]interface{})[0].(map[string]interface{})["email"])

	objectId := primitive.NewObjectID()

	//turn dob to date of birth
	dateString := data["results"].([]interface{})[0].(map[string]interface{})["dob"].(map[string]interface{})["date"].(string)
	parsedDate, err := time.Parse(time.RFC3339, dateString)
	if err != nil {
		fmt.Println("Error parsing date:", err)
		return models.User{}, err
	}
	dob := models.DateOfBirth{
		Day:   parsedDate.Day(),
		Month: int(parsedDate.Month()),
		Year:  parsedDate.Year(),
	}

	resultUser := models.User{
		ID:                &objectId,
		Email:             data["results"].([]interface{})[0].(map[string]interface{})["email"].(string),
		Verified_email:    true,
		PhoneNumber:       data["results"].([]interface{})[0].(map[string]interface{})["phone"].(string),
		FirstName:         data["results"].([]interface{})[0].(map[string]interface{})["name"].(map[string]interface{})["first"].(string),
		LastName:          data["results"].([]interface{})[0].(map[string]interface{})["name"].(map[string]interface{})["last"].(string),
		Gender:            data["results"].([]interface{})[0].(map[string]interface{})["gender"].(string),
		Location:          data["results"].([]interface{})[0].(map[string]interface{})["location"].(map[string]interface{})["country"].(string),
		RelationshipTypes: []string{"Friendship", "Dating", "Marriage"},
		DateOfBirth:       &dob,
		Height: &models.Height{
			Feet:   5,
			Inches: 8,
		},
		Providers: map[string]models.Provider{
			"google": {
				Name:           data["results"].([]interface{})[0].(map[string]interface{})["name"].(map[string]interface{})["first"].(string) + " " + data["results"].([]interface{})[0].(map[string]interface{})["name"].(map[string]interface{})["last"].(string),
				Email:          data["results"].([]interface{})[0].(map[string]interface{})["email"].(string),
				Email_verified: true,
				Sub:            "sub",
			},
		},
		MediaFiles: []string{
			data["results"].([]interface{})[0].(map[string]interface{})["picture"].(map[string]interface{})["large"].(string),
		},
	}

	return resultUser, nil

}

func generate_100_Users() ([]models.User, error) {
	users := make([]models.User, 100)
	var err error
	for i := 0; i < 100; i++ {
		users[i], err = get_random_user()
		if err != nil {
			return users, err
		}
	}

	return users, nil

}

func insert_Mock_Users() error {
	users, err := generate_100_Users()
	if err != nil {
		return err
	}

	for _, user := range users {
		//insert user into database
		_, err := DBManager.DB.Collection("users").InsertOne(context.Background(), user)
		if err != nil {
			return err
		}

	}
	return nil
}

func Gen_Mock_Users() error {
	err := insert_Mock_Users()
	if err != nil {
		fmt.Println("Error inserting mock users:", err)
		return err
	}
	return nil
}
