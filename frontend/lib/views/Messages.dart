import 'package:eunity/widgets/Tiles/chat_tile.dart';
import 'package:eunity/widgets/matchesWidget/match_tile.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(),
        body: ChatScreen(),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<MatchModel> matches = [
    MatchModel(
        avatarPath: 'assets/FakePeople/StephanieBrown.png', name: 'Amaya'),
    MatchModel(avatarPath: 'assets/FakePeople/ClaraSmith.png', name: 'Emi'),
    MatchModel(avatarPath: 'assets/FakePeople/ErinGreen.png', name: 'Brittney'),
    MatchModel(avatarPath: 'assets/FakePeople/MollyTaylor.png', name: 'Karen'),
    // Add more MatchModel instances here
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      flexibleSpace: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height:
                  MediaQuery.of(context).padding.top), // for status bar padding
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'New matches',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150, // Adjusted height to fit the avatars
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MatchTile(match: matches[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(200); // Adjusted height to fit the content
}

class ChatScreen extends StatelessWidget {
  final List<ChatModel> chats = [
    ChatModel(
      avatarUrl: 'assets/FakePeople/StephanieBrown.png',
      name: 'Stephanie',
      datetime: DateTime.now().subtract(const Duration(minutes: 5)),
      message: 'I love dogs too!',
      isOnline: true,
      unreadMessages: 1,
    ),
    ChatModel(
      avatarUrl: 'assets/FakePeople/ClaraSmith.png',
      name: 'Clara',
      datetime: DateTime.now().subtract(const Duration(minutes: 120)),
      message: 'That was a fun date!',
      isOnline: true,
      unreadMessages: 2,
    ),
    ChatModel(
      avatarUrl: 'assets/FakePeople/ErinGreen.png',
      name: 'Molly',
      datetime: DateTime.now().subtract(const Duration(minutes: 165)),
      message: 'Where do you go to school?',
      isOnline: false,
      unreadMessages: 0,
    ),
    ChatModel(
      avatarUrl: 'assets/FakePeople/MollyTaylor.png',
      name: 'Jane',
      datetime: DateTime.now().subtract(const Duration(minutes: 405)),
      message: 'Nice to meet you!',
      isOnline: true,
      unreadMessages: 0,
    ),
    // Add more ChatModel instances here
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ChatTile(chat: chats[index]),
            const Divider(),
          ],
        );
      },
    );
  }
}
