import 'package:flutter/material.dart';
import 'package:frontend/widgets/NotificationWidgets/NotificationGroup.dart';
import 'package:frontend/widgets/TopBars/PushedScreenWithIconTopBar.dart';
import 'dart:math';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List notificationGroups = [];

  final List imageURLS = [
    'assets/FakePeople/StephanieBrown.png',
    'assets/FakePeople/ClaraSmith.png',
    'assets/FakePeople/ErinGreen.png',
    'assets/FakePeople/MollyTaylor.png'
  ];
  final List userNames = ['Stephanie', 'Clara', 'Erin', 'Molly'];

  final List sampleDates = [
    'Today',
    'Yesterday',
    '5/25/2024',
    '5/24/2024',
    '5/23/2024',
    '5/22/2024',
    '5/21/2024'
  ];

  final List sections = [9, 6, 3, 12];

  final List mList = ['PM', 'AM'];

  Future<void> loadNotifications() async {
    final random = Random();

    notificationGroups.clear();

    for (var date in sampleDates) {
      List newGroup = [];
      for (var mGroup in mList) {
        for (var timeSection in sections) {
          int rollCheck = random.nextInt(2);
          if (rollCheck == 1) {
            int hourOffset = random.nextInt(3);
            int newHour = timeSection + hourOffset;
            if (newHour > 12) {
              newHour -= 12;
            }
            int minutes = random.nextInt(50) + 10;
            String timestamp = '$date at $newHour:$minutes $mGroup';
            int userRoll = random.nextInt(4);
            String imageURL = imageURLS[userRoll];
            String userName = userNames[userRoll];
            int typeCheck = random.nextInt(2);
            String title;
            String goTo;
            if (typeCheck == 1) {
              title = 'You Matched with $userName!';
              goTo = 'Visit Profile';
            } else {
              title = '$userName Sent You a Message!';
              goTo = 'Go to Messages';
            }
            Map<String, String> dataEntry = {
              'imageURL': imageURL,
              'timestamp': timestamp,
              'title': title,
              'goTo': goTo
            };
            newGroup.add(dataEntry);
          }
        }
      }
      if (newGroup.isNotEmpty) {
        notificationGroups.add(newGroup);
      }
    }
  }

  void firstload() {
    loadNotifications();
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () => loadNotifications(),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (notificationGroups.isEmpty && index == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (index >= notificationGroups.length - 5) {
            if (index >= notificationGroups.length) {
              return null;
            }
            return NotificationGroup(
              notificationList: notificationGroups[index],
              groupLabel: sampleDates[index],
            );
          }
          return NotificationGroup(
            notificationList: notificationGroups[index],
            groupLabel: sampleDates[index],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    firstload();
    return Scaffold(
      appBar: PushedScreenWithIconTopBar(
        title: "Recent Notifications",
        assetPath: "assets/NavBarUI/icon-bell.svg",
      ),
      body: notificationGroups.isNotEmpty
          ? _buildList()
          : Center(
              child: Text("No Notifications Here!"),
            ),
    );
  }
}
