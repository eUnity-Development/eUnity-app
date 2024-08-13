package WSManager

import (
	"encoding/json"
	"fmt"
	"log"

	m "eunity.com/backend-main/models"
	"github.com/gorilla/websocket"
)

// create empty set of connections
var connections = make(map[string]*m.WSconnection)

// message must be sent in standard JSON format
// delivered status is updated once client echoes back the message
func SendMessage(message *m.Message) error {

	//check if connection exists

	userID := message.To
	fmt.Println("User ID: ", userID)
	fmt.Println("Message: ", message)

	//turn message into json
	jsonMessage, err := json.Marshal(message)
	if err != nil {
		log.Println("Error marshalling message:", err)
		return err
	}

	if connections[userID] != nil {
		conn := connections[userID].Conn
		conn.WriteMessage(websocket.TextMessage, []byte(jsonMessage))

		//later here we need to make sure that front_end echos the full message back
		_, msg, err := conn.ReadMessage()
		if err != nil {
			log.Println("Error reading message:", err)
		}
		log.Printf("Received from here message: %s", msg)
		//print message
		log.Println("Message sent to user: ", message)

	} else {
		//return error connection does not exis
		return &websocket.CloseError{Code: websocket.CloseNoStatusReceived, Text: "Connection does not exist"}
	}

	return nil

}

func AddConnection(userID string, conn *websocket.Conn) {
	connections[userID] = &m.WSconnection{UserId: userID, Conn: conn}
}
