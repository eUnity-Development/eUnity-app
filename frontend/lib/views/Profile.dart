import 'package:eunity/classes/AuthHelper.dart';
import 'package:eunity/views/EditProfile.dart';
import 'package:eunity/views/LoginSignup.dart';
import 'package:eunity/views/ReportIssue.dart';
import 'package:eunity/views/Settings.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/FeedbackScreen.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List imageArray = [];
  int selectedImageGrid = 0;
  bool signingOut = false;
  late String bioText;

  @override
  void initState() {
    super.initState();
    updateData();
    bioText = UserInfoHelper.userInfoCache['bio'];
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
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile()),
    );
    if (mounted) {
      setState(() {
        bioText = UserInfoHelper.userInfoCache['bio'];
        print(bioText);
      });
    }
  }

  void navigateToReportIssue() async {
    print('clicked report issue');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportIssue()),
    );
  }

  void navigateToSettings() async {
    print('clicked settings');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings()),
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

    Widget menuButton(String assetPath, String buttonLabel, double iconHeight) {
      return Container(
        height: 34,
        width: 162,
        decoration: BoxDecoration(
            border: Border.all(color: DesignVariables.greyLines, width: 1),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                assetPath,
                height: iconHeight,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                buttonLabel,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(64, 0, 0, 0),
                          spreadRadius: 0,
                          blurRadius: 4 * DesignVariables.widthConversion,
                          offset:
                              Offset(0, 4 * DesignVariables.heightConversion),
                        ),
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        UserInfoHelper.getPublicImageURL(
                            UserInfoHelper.userInfoCache['media_files'][0])),
                    radius: 69 * DesignVariables.widthConversion,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      UserInfoHelper.userInfoCache['first_name'],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      child: menuButton(
                          "assets/MiscIcons/icon-pencil-square.svg",
                          'Edit Profile',
                          24),
                      onTap: navigateToEditProfile,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: menuButton(
                          "assets/MiscIcons/icon-gear.svg", 'Settings', 18),
                      onTap: navigateToSettings,
                    ),
                  ],
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Bio',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        bioText,
                        textAlign: TextAlign.left,
                        maxLines: null,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),
                  ],
                )),
            Spacer(),
            Text(
              "Share your Feedback",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: menuButton(
                      "assets/MiscIcons/icon-thumbsup.svg", 'Feedback', 18),
                  onTap: navigateToFeedback,
                ),
                GestureDetector(
                  child: menuButton("assets/MiscIcons/icon-megaphone.svg",
                      'Report Issue', 24),
                  onTap: navigateToReportIssue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
