import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/FeedbackScreen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void testFeedback() async {
    print("clicked feedback");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: GestureDetector(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(width: 1, color: DesignVariables.greyLines),
                  color: DesignVariables.primaryRed),
              height: 51,
              width: 207,
              child: Center(
                child: Text(
                  "Test Feedback Button",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              )),
          onTap: testFeedback,
        ),
      ),
    );
  }
}
