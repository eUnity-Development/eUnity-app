package models

import (
	"time"

	"github.com/gorilla/websocket"
)

type WSconnection struct {
	UserId    string
	Conn      *websocket.Conn
	CreatedAt time.Time
	UpdatedAt time.Time
}
