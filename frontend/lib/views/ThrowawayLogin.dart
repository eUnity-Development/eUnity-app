import 'package:flutter/material.dart';
import 'package:frontend/classes/DesignVariables.dart';
import 'package:frontend/classes/AuthHelper.dart';
import 'package:frontend/views/CoreTemplate.dart';
import 'package:frontend/widgets/splash_screen_button.dart';

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

          const Center(
            child: Image(
              image: AssetImage('assets/e-unity-logo-and-name.png'),
              width: 330,
              height: 118.75,
            ),
          ),

          const SizedBox(
            height: 45,
          ),

          Center(
            child: Text(
              "Unite with your soulmate!",
              style: TextStyle(
                color: DesignVariables.primaryRed,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(
            height: 73,
          ),

          SplashScreenButton(
            text: "Sign Up Here!",
            color: Colors.transparent,
            borderColor: DesignVariables.primaryRed,
            textColor: DesignVariables.primaryRed,
            onTap: testSignup,
          ),
          
          const SizedBox(
            height: 92,
          ),

          SplashScreenButton(
            text: "Login",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            onTap: testLogin,
          ),

          const SizedBox(
            height: 31,
          ),

          SplashScreenButton(
            text: "Phone Number",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            onTap: testLogin,
          ),

          const SizedBox(
            height: 31,
          ),

          SplashScreenButton(
            text: "Google",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            onTap: testLogin,
          ),

          const SizedBox(
            height: 31,
          ),

          SplashScreenButton(
            text: "Facebook",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            onTap: testLogin,
          ),
        ],
      ),
    );
  }
}
