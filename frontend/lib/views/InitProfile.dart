import 'package:eunity/classes/AuthHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/views/NameDOBGender.dart';
import 'package:eunity/widgets/TopBars/OnlyLogoTopBar.dart';
import 'package:flutter/material.dart';

class InitProfile extends StatelessWidget {
  const InitProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> executeLogout() async {
      await AuthHelper.signOut();
      await AuthHelper.isLoggedIn();
    }

    return Scaffold(
      appBar: OnlyLogoTopBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Profile Set-Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'You are logged into your account, but you have not yet set-up your profile. In order to use eUnity, please follow the instructions to set up your profile and start making connections! Alternatively, you may log out and sign-in into an alternate account if you so choose.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: DesignVariables.primaryRed,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Set Up Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                ),
                onTap: () async {
                  await UserInfoHelper.getUserInfo();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NameDOBGender()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: DesignVariables.offWhite,
                    borderRadius: BorderRadius.circular(25),
                    border:
                        Border.all(color: DesignVariables.greyLines, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                ),
                onTap: () async {
                  print("Clicked Logout");
                  await executeLogout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
