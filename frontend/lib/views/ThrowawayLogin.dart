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
    /*
    Since we used an iPhone 15 pro max (size: 430x932) for Figma, it's important to
    consider other screen sizes. This is why I've made a ratio of the sizes we have
    on Figma divided by the iPhone's size, which ensures that ratio will be mantained
    on other devices.
    
    TLDR: Makes things scale nicely on smaller screens, so it'll look closer to Figma.
    */
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final btnWidth = (334.67/430) * screenWidth;
    final btnHeight = (52/932) * screenHeight;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: Image(
              image: const AssetImage('assets/e-unity-logo-and-name.png'),
              width: ((330/430) * screenWidth),
              height: ((118.75/932) * screenHeight),
            ),
          ),

          SizedBox(
            height: ((45/932) * screenHeight),
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

          SizedBox(
            height: ((73/932) * screenHeight)
          ),

          SplashScreenButton(
            text: "Sign Up Here!",
            color: Colors.transparent,
            borderColor: DesignVariables.primaryRed,
            textColor: DesignVariables.primaryRed,
            height: btnHeight,
            width: btnWidth,
            onTap: testSignup,
          ),
          
          SizedBox(
            height: ((92/932) * screenHeight)
          ),

          SplashScreenButton(
            text: "Login",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),

          SizedBox(
            height: ((31/932) * screenHeight)
          ),

          SplashScreenButton(
            text: "Phone Number",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),

          SizedBox(
            height: ((31/932) * screenHeight)
          ),

          SplashScreenButton(
            text: "Google",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),

          SizedBox(
            height: ((31/932) * screenHeight)
          ),

          SplashScreenButton(
            text: "Facebook",
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),
        ],
      ),
    );
  }
}
