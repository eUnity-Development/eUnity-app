package models

import "time"

// messages belong to conversation with have two keys
// being the respective user ids
type Message struct {
	ConversationID string `json:"conversation_id"`
	From           string `json:"from"`
	To             string `json:"to"`
	Message        string `json:"message"`
	CreatedAt      string `json:"created_at"`
	Delivered      bool   `json:"delivered"`
	Read           bool   `json:"read"`
}

func (m *Message) NewMessage(convID string, from string, to string, message string) *Message {
	return &Message{
		ConversationID: convID,
		From:           from,
		To:             to,
		Message:        message,
		CreatedAt:      time.Now().String(),
		Delivered:      false,
		Read:           false,
	}
}
