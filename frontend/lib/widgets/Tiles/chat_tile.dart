import 'package:flutter/material.dart';

class ChatModel {
  final String avatarUrl;
  final String name;
  final DateTime datetime;
  final String message;
  final bool isOnline;
  final int unreadMessages;

  ChatModel({
    required this.avatarUrl,
    required this.name,
    required this.datetime,
    required this.message,
    required this.isOnline,
    required this.unreadMessages,
  });
}

class ChatTile extends StatelessWidget {
  final ChatModel chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(chat.avatarUrl),
          ),
          if (chat.isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '${chat.datetime.hour}:${chat.datetime.minute.toString().padLeft(2, '0')} ${chat.datetime.hour >= 12 ? 'PM' : 'AM'}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(chat.message, overflow: TextOverflow.ellipsis)),
          if (chat.unreadMessages > 0)
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text(
                chat.unreadMessages.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
