package controllers

import (
	"log"
	"time"

	"eunity.com/backend-main/helpers/WSManager"
	"eunity.com/backend-main/models"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

type Messaging_controllers struct {
}

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
}

// Send_message godoc
// @Summary Send a message
// @Description Send a message
// @Tags Messaging
// @Accept  json
// @Produce  json
// @Param message query string true "Message to send"
// @Param userID query string true "userId of the user"
// @Success 200 {object} string
// @Router /messaging/send [post]
func (m *Messaging_controllers) Send_message(c *gin.Context) {
	message := c.Query("message")
	//get user id from context
	from := c.GetString("user_id")
	to := c.Query("user_id")

	//get this users id

	//get conversation from backend and use it to create a message object
	conversationID := "placeholder"

	var messageObject *models.Message
	messageObject = messageObject.NewMessage(conversationID, from, to, message)

	//just echo message back
	err := WSManager.SendMessage(messageObject)
	if err != nil {
		c.JSON(500, gin.H{
			"message": "Error sending message",
		})
		return
	}

	c.JSON(200, gin.H{
		"success": true,
	})
}

func (m *Messaging_controllers) Web_Socket_Connection(c *gin.Context) {

	//get user id from context
	user_id := c.GetString("user_id")
	log.Println("User id: ", user_id)

	conn, err := upgrader.Upgrade(c.Writer, c.Request, nil)
	if err != nil {
		log.Println(err)
		return
	}
	//add connection to connections
	WSManager.AddConnection(user_id, conn)

	defer conn.Close()
	for {
		time.Sleep(5 * time.Second)
	}
}
