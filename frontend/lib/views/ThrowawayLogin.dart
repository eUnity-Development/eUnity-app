import 'package:flutter/material.dart';
import 'package:frontend/classes/DesignVariables.dart';
import 'package:frontend/classes/AuthHelper.dart';
import 'package:frontend/views/CoreTemplate.dart';

class ThrowawayLogin extends StatefulWidget {
  const ThrowawayLogin({super.key});

  @override
  State<ThrowawayLogin> createState() => _ThrowawayLoginState();
}

class _ThrowawayLoginState extends State<ThrowawayLogin> {
  @override
  void initState() {
    super.initState();
    AuthHelper.isLoggedIn().then((value) {
      if (value) {
        navigateToPrimaryScreens();
      }
    });
  }

  void navigateToPrimaryScreens() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CoreTemplate()),
        (route) => false);
  }

  void testSignup() async {
    print("clicked signup");
    var response = await AuthHelper.signUp("testemail@test.com", "Test123123");
    print(response);
  }

  void testLogin() async {
    print("clicked login");
    var response = await AuthHelper.login("testemail@test.com", "Test123123");
    print(response);
    bool loginCheck = await AuthHelper.isLoggedIn();
    if (loginCheck) {
      navigateToPrimaryScreens();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(width: 1, color: DesignVariables.greyLines),
                    color: DesignVariables.primaryRed),
                height: 51,
                width: 207,
                child: Text(
                  "Test Signup Button",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
            onTap: testSignup,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(width: 1, color: DesignVariables.greyLines),
                    color: DesignVariables.primaryRed),
                height: 51,
                width: 207,
                child: Text(
                  "Test Login Button",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
            onTap: testLogin,
          ),
        ],
      ),
    );
  }
}
