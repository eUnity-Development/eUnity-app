import 'package:eunity/classes/AuthHelper.dart';
import 'package:eunity/views/EditProfile.dart';
import 'package:eunity/views/LoginSignup.dart';
import 'package:eunity/views/ReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/FeedbackScreen.dart';
import 'package:eunity/classes/UserInfoHelper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List imageArray = [];
  int selectedImageGrid = 0;
  bool signingOut = false;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future<void> updateData() async {
    var response = await UserInfoHelper.getUserInfo();
    setState(() {
      if (response.data.containsKey('media_files')) {
        imageArray = response.data['media_files'];
      } else {
        imageArray = [];
      }
    });
  }

  void navigateToFeedback() async {
    print("clicked feedback");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackScreen()),
    );
  }

  void navigateToEditProfile() async {
    print("clicked edit profile");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile()),
    );
  }

  //This realistically should not be here at all when we get to the actual place. Just a nice little place to put it
  void navigateToReportTest() async {
    print('clicked report');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    void navigateBackToLogin() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginSignup()),
          (route) => false);
    }

    void handleSignOut() async {
      await AuthHelper.signOut();
      navigateBackToLogin();
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 1, color: DesignVariables.greyLines),
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
              onTap: navigateToFeedback,
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 1, color: DesignVariables.greyLines),
                      color: DesignVariables.primaryRed),
                  height: 51,
                  width: 207,
                  child: Center(
                    child: Text(
                      "Go To Edit Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              onTap: navigateToEditProfile,
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 1, color: DesignVariables.greyLines),
                      color: DesignVariables.primaryRed),
                  height: 51,
                  width: 207,
                  child: Center(
                    child: Text(
                      "Test Report Screen",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              onTap: navigateToReportTest,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () => {
                      handleSignOut(),
                      setState(() {
                        signingOut = true;
                      })
                    },
                child: const Text("Sign Out")),
            Visibility(
              visible: signingOut,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(DesignVariables.primaryRed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
