import 'package:eunity/classes/SwipeHelper.dart';
import 'package:eunity/classes/UserStackHelper.dart';
import 'package:flutter/material.dart';

class Swiping extends StatefulWidget {
  const Swiping({Key? key}) : super(key: key);

  @override
  State<Swiping> createState() => _SwipingState();
}

class _SwipingState extends State<Swiping> with SingleTickerProviderStateMixin {
  int currentUserIndex = 1;
  List<dynamic> stackArray = [];
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future<void> updateData() async {
    var response = await UserStackHelper.getUserStack();
    setState(() {
      stackArray = response.data;
      isLoading = false; // Set loading to false when data is loaded
      print(stackArray[0]['first_name']);
    });
  }

  void _onHeartPressed() async {
  // Call the SwipeHelper to register a right swipe (true for like)
  final swipedUserId = stackArray[currentUserIndex]['_id']; // Assuming the user's ID is stored under 'id'
  final response = await SwipeHelper.addUserSwipe(swipedUserId, true);

  if (response.statusCode == 200) {
    print('Swipe added successfully');
  } else {
    print('Error adding swipe');
  }

  // Update the UI
  setState(() {
    if (currentUserIndex < stackArray.length - 1) {
      currentUserIndex++;
    } else {
      currentUserIndex = 0;
    }
  });
}

void _onPassPressed() async {
  // Call the SwipeHelper to register a left swipe (false for pass)
  final swipedUserId = stackArray[currentUserIndex]['_id'];
  final response = await SwipeHelper.addUserSwipe(swipedUserId, false);

  if (response.statusCode == 200) {
    print('Swipe added successfully');
  } else {
    print('Error adding swipe');
  }

  // Update the UI
  setState(() {
    if (currentUserIndex < stackArray.length - 1) {
      currentUserIndex++;
    } else {
      currentUserIndex = 0;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: isLoading // Check if data is still loading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : Draggable(
              feedback: UserCard(currentUserIndex: currentUserIndex),
              childWhenDragging: UserCard(currentUserIndex: currentUserIndex + 1),
              child: UserCard(currentUserIndex: currentUserIndex),
              onDragEnd: (drag) {
                if (drag.velocity.pixelsPerSecond.dx < -500) {
                  print("Swipe left");
                  _onPassPressed();
                }
                if (drag.velocity.pixelsPerSecond.dx > 500) {
                  print("Swipe right");
                  _onHeartPressed();
                }
              },
            ),
      floatingActionButton: isLoading // Disable buttons while loading
          ? null
          : ReactButtons(
              onHeartPressed: _onHeartPressed,
              onPassPressed: _onPassPressed,
            ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.currentUserIndex,
  });

  final int currentUserIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: SizedBox(
      height: MediaQuery.of(context).size.height / 1.175,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  UserStackHelper.userStackCache[currentUserIndex]['media_files'][0]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(200, 0, 0, 0),
                  Color.fromARGB(0, 0, 0, 0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            child: Text(
              UserStackHelper.userStackCache[currentUserIndex]['gender'],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontSize: 20,
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            left: 20,
            child: Text(
              UserStackHelper.userStackCache[currentUserIndex]['first_name'],
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ),
            );
  }
}

class ReactButtons extends StatelessWidget {
  final VoidCallback onHeartPressed;
  final VoidCallback onPassPressed;

  const ReactButtons({
    super.key,
    required this.onHeartPressed,
    required this.onPassPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPassPressed,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 236, 236, 236).withOpacity(.8),
            ),
            child: const Icon(Icons.clear_rounded, color: Colors.black),
          ),
        ),
        SizedBox(width: 30),
        GestureDetector(
          onTap: onHeartPressed,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5C5C).withOpacity(.8),
            ),
            child: const Icon(Icons.favorite, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
