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

func get_random_user(amount string) ([]models.User, error) {
	// URL of the API endpoint
	url := "https://randomuser.me/api/?results=" + fmt.Sprint(amount)

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
	var data struct {
		Results []map[string]interface{} `json:"results"`
	}
	err = json.NewDecoder(resp.Body).Decode(&data)
	if err != nil {
		log.Fatalf("Error decoding JSON: %v", err)
	}

	var users []models.User
	for _, userData := range data.Results {
		objectId := primitive.NewObjectID()

		// Parse date of birth
		dateString := userData["dob"].(map[string]interface{})["date"].(string)
		parsedDate, err := time.Parse(time.RFC3339, dateString)
		if err != nil {
			fmt.Println("Error parsing date:", err)
			return nil, err
		}
		dob := models.DateOfBirth{
			Day:   parsedDate.Day(),
			Month: int(parsedDate.Month()),
			Year:  parsedDate.Year(),
		}

		user := models.User{
			ID:             &objectId,
			Email:          userData["email"].(string),
			Verified_email: true,
			PhoneNumber:    userData["phone"].(string),
			FirstName:      userData["name"].(map[string]interface{})["first"].(string),
			LastName:       userData["name"].(map[string]interface{})["last"].(string),
			Gender:         userData["gender"].(string),
			Location:       userData["location"].(map[string]interface{})["country"].(string),
			MatchPreferences: models.MatchPreferences{
				Genders:           []string{"Men", "Women"},
				RelationshipTypes: []string{"Long Term Relationships"},
				MinimumAge:        18,
				MaximumAge:        39,
				MaximumDistance:   40,
			},
			DateOfBirth: &dob,
			Height: &models.Height{
				Feet:   5,
				Inches: 8,
			},
			Providers: map[string]models.Provider{
				"google": {
					Name:           userData["name"].(map[string]interface{})["first"].(string) + " " + userData["name"].(map[string]interface{})["last"].(string),
					Email:          userData["email"].(string),
					Email_verified: true,
					Sub:            "sub",
				},
			},
			MediaFiles: []string{
				userData["picture"].(map[string]interface{})["large"].(string),
			},
		}
		users = append(users, user)
	}

	return users, nil

}

func generate_x_Users(amount string) ([]models.User, error) {
	return get_random_user(amount)
}

func insert_Mock_Users(amount string) (*models.User, error) {
	users, err := generate_x_Users(amount)
	if err != nil {
		return nil, err
	}

	for _, user := range users {
		//insert user into database
		_, err := DBManager.DB.Collection("users").InsertOne(context.Background(), user)
		if err != nil {
			return nil, err
		}

	}
	return &users[0], nil
}

func Gen_Mock_Users(amount string) (*models.User, error) {
	user, err := insert_Mock_Users(amount)
	if err != nil {
		fmt.Println("Error inserting mock users:", err)
		return nil, err
	}
	return user, nil
}
