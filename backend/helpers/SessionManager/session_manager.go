package SessionManager

import (
	"os"

	"eunity.com/backend-main/models"
	"github.com/joho/godotenv"
)

// retrieves session data using the session_id stored in the cookies
var ValKey bool

func init() {
	godotenv.Load()
	valkey := os.Getenv("VALKEY_ENABLED")
	if valkey == "true" {
		ValKey = true
	} else {
		ValKey = false
	}
}

func Get_Session(session_id string) (models.Session, error) {
	switch ValKey {
	case true:
		//get session id from valkey
	default:
		//get session id from mongo db
	}
}

func Create_Session(user_id string) (models.Session, error) {
	switch ValKey {
	case true:
		//create session id in valkey
	default:
		//create session id in mongo db
	}

}
