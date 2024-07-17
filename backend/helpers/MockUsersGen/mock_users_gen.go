package MockUsersGen

import (
	"context"

	"eunity.com/backend-main/helpers/DBManager"
	"eunity.com/backend-main/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

var firstNames = []string{
	"Aleah", "Kylan", "Haley", "Krew", "Eve", "Briggs", "Kataleya", "Franklin", "Jocelyn", "Frederick",
	"Waverly", "Bode", "Chaya", "Duncan", "Lara", "Drake", "Catalina", "Mario", "Mina", "Chaim",
	"Lia", "Shiloh", "Elle", "Alan", "Alena", "Dawson", "Melanie", "Lawson", "Makayla", "Adriel",
	"Amara", "Harley", "Grace", "Lawson", "Halo", "Abdiel", "Jessie", "Augustus", "Marisol", "Everett",
	"Briella", "Ian", "Aubrey", "Bear", "Dani", "Reed", "Kelly", "Winston", "Elsie", "Barrett",
	"Bria", "Wells", "Shiloh", "Kyle", "Delaney", "Valentin", "Kylie", "Brian", "Irene", "Idris",
	"Hunter", "Ricardo", "Amayah", "Ermias", "Laura", "Cohen", "Alani", "Connor", "Kamilah", "Bjorn",
	"Esme", "Riggs", "Marleigh", "Kye", "Anastasia", "Maddox", "Rosemary", "Parker", "Kaia", "Ryan",
	"Addison", "Connor", "Shay", "Bryan", "Paisley", "Marvin", "Mary", "William", "Alana", "Caiden",
	"Yaretzi", "Amir", "Gabriella", "Jorge", "Paris", "Leonel", "Daphne", "Kyng", "Adriana", "Melvin",
}

var lastNames = []string{
	"Kramer", "Bauer", "Humphrey", "Hodges", "Curry", "Winters", "Griffith", "Gilbert", "Wise", "Barry",
	"Morse", "Boyer", "Lu", "Baxter", "Sparks", "Stone", "Lambert", "Atkins", "Booth", "Park",
	"Anthony", "Graves", "Gardner", "Bond", "Dunn", "Sullivan", "Becker", "Chambers", "Owens", "Fernandez",
	"Barr", "Ramirez", "Becker", "McCarty", "Andrade", "Villegas", "Osborne", "Pollard", "Hughes", "Schultz",
	"Chavez", "Parker", "Rivers", "Hendricks", "Brady", "English", "Ochoa", "Sandoval", "Soto", "Palacios",
	"Lang", "Goodwin", "Joseph", "Schneider", "Knox", "Tran", "Sims", "Combs", "Noble", "Noble",
	"Leonard", "Xiong", "Gates", "Becker", "Wang", "Delgado", "Cox", "Stark", "McKee", "Velasquez",
	"Jaramillo", "McClain", "Ellison", "Simpson", "Hicks", "Reese", "Patel", "Acosta", "Cruz", "Campbell",
	"Cox", "Mullen", "Jacobs", "Roberts", "Conley", "Moreno", "Jones", "Santos", "Lara", "Floyd",
	"Patterson", "Kim", "Li", "Pacheco", "Shelton", "Paul", "Duffy", "May", "Kemp", "Costa",
}

var phoneNumbers = []string{
	"555-0123", "555-0456", "555-0789", "555-0111", "555-0222",
	"555-0333", "555-0444", "555-0555", "555-0666", "555-0777",
	"555-0888", "555-0999", "555-1234", "555-2345", "555-3456",
	"555-4567", "555-5678", "555-6789", "555-7890", "555-8901",
	"555-9012", "555-1122", "555-2233", "555-3344", "555-4455",
	"555-5566", "555-6677", "555-7788", "555-8899", "555-9900",
	"555-1010", "555-2121", "555-3232", "555-4343", "555-5454",
	"555-6565", "555-7676", "555-8787", "555-9898", "555-0001",
	"555-1111", "555-2222", "555-3333", "555-4444", "555-5555",
	"555-6666", "555-7777", "555-8888", "555-9999", "555-1212",
	"555-1313", "555-1414", "555-1515", "555-1616", "555-1717",
	"555-1818", "555-1919", "555-2020", "555-3131", "555-4242",
	"555-5353", "555-6464", "555-7575", "555-8686", "555-9797",
	"555-0101", "555-0202", "555-0303", "555-0404", "555-0505",
	"555-0606", "555-0707", "555-0808", "555-0909", "555-1011",
	"555-1213", "555-1415", "555-1617", "555-1819", "555-2021",
	"555-2223", "555-2425", "555-2627", "555-2829", "555-3031",
	"555-3233", "555-3435", "555-3637", "555-3839", "555-4041",
	"555-4243", "555-4445", "555-4647", "555-4849", "555-5051",
	"555-5253", "555-5455", "555-5657", "555-5859", "555-6061",
	"555-6263", "555-6465", "555-6667", "555-6869", "555-7071",
}

func generate_100_Users() []models.User {
	users := make([]models.User, 100)

	for i := 0; i < 100; i++ {
		objectId := primitive.NewObjectID()
		users[i] = models.User{
			ID:             &objectId,
			Email:          lastNames[i] + "." + firstNames[i] + "@gmail.com",
			Verified_email: true,
			PhoneNumber:    phoneNumbers[i],
			FirstName:      firstNames[i],
			LastName:       lastNames[i],
			Gender:         "can't be bothered bro",
			Location:       "can't be bothered bro",
			Height: &models.Height{
				Feet:   5,
				Inches: 10,
			},
			RelationshipTypes: []string{"can't be bothered bro"},
			DateOfBirth: &models.DateOfBirth{
				Day:   1,
				Month: 1,
				Year:  2000,
			},
			Providers: map[string]models.Provider{
				"google": {
					Name:           firstNames[i] + " " + lastNames[i],
					Email:          lastNames[i] + "." + firstNames[i] + "@gmail.com",
					Email_verified: true,
					Sub:            "sub",
				},
			},
			MediaFiles: []string{},
		}
	}

	return users

}

func insert_Mock_Users() error {
	users := generate_100_Users()

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
		return err
	}
	return nil
}
