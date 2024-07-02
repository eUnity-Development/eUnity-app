import 'package:dio/dio.dart';
import 'package:eunity/views/NameDOBGender.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/AuthHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/PhoneLogin.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  @override
  void initState() {
    super.initState();
    AuthHelper.isLoggedIn().then((value) {
      if (value) {
        print("logging in right here");
        AuthHelper.setLoggedIn(true);
      }
    });

    //when we detect user change we trigger this function
    AuthHelper.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      GoogleSignInAuthentication? auth = await account?.authentication;
      if (auth != null) {
        String googleKey = auth.idToken!;
        if (AuthHelper.loggedIn) return;
        Response res = await AuthHelper.verifyGoogleIDToken(googleKey);
        if (res.statusCode == 200) {
          AuthHelper.setLoggedIn(true);
        }
      }
    });

    //try to login silently on app load
    AuthHelper.googleSignIn.signInSilently();
  }

  void navigateToPhoneLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PhoneLogin()),
    );
  }

  void handleGoogleSignInClick() async {
    await AuthHelper.signInWithGoogle();
  }

  void testSignup() async {
    print("clicked signup");
    navigateToPhoneLogin();
  }

  void testLogin() async {
    print("clicked login");
    //var response = await AuthHelper.login("testemail@test.com", "Test123123");
    //print(response);
    //bool loginCheck = await AuthHelper.isLoggedIn();
    //if (loginCheck) {
    navigateToPhoneLogin();
    //}
  }

  void forceLogin() async {
    print('forced login');
    await AuthHelper.signUp("testemail@test.com", "Test123123");
    await AuthHelper.login("testemail@test.com", "Test123123");
    bool loginCheck = await AuthHelper.isLoggedIn();
    if (loginCheck) {
      AuthHelper.setLoggedIn(true);
    }
  }

  // Temporary function to get to profile setup screens
  void navigateToProfileSetup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NameDOBGender()),
    );
  }

  @override
  Widget build(BuildContext context) {

    final double btnWidth = 334 * DesignVariables.widthConversion;
    final double btnHeight = 52 * DesignVariables.heightConversion;

    final double svgOffset = 20 * DesignVariables.widthConversion;
    const double svgDimensions = 27;
    const double fontSize = 16.5;
    const Color fontColor = Color.fromRGBO(0, 0, 0, 0.5);

    final Color loginBorder = DesignVariables.greyLines;
    const Color loginBackground = Colors.transparent;

    final double spaceBetweenLogin = 31 * DesignVariables.heightConversion;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: const AssetImage('assets/e-unity-logo-and-name.png'),
              width: 330 * DesignVariables.widthConversion,
              height: 118.75 * DesignVariables.heightConversion,
            ),
          ),

          SizedBox(
            height: 45 * DesignVariables.heightConversion,
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

          SizedBox(height: 73 * DesignVariables.heightConversion),

          // Phone login
          LoginSignupButton(
            color: loginBackground,
            borderColor: loginBorder,
            buttonContent: LoginSignupButtonContent(
                svgOffset: svgOffset,
                svgPath: 'assets/login/phone.svg',
                svgDimensions: svgDimensions,
                text: 'Log in with phone number',
                fontSize: fontSize,
                fontColor: fontColor),
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),

          SizedBox(height: spaceBetweenLogin),

          // Google login
          LoginSignupButton(
            color: loginBackground,
            borderColor: loginBorder,
            buttonContent: LoginSignupButtonContent(
                svgOffset: svgOffset,
                svgPath: 'assets/login/google_icon.svg',
                svgDimensions: svgDimensions,
                text: 'Log in with Google',
                fontSize: fontSize,
                fontColor: fontColor),
            height: btnHeight,
            width: btnWidth,
            onTap: handleGoogleSignInClick,
          ),

          SizedBox(height: spaceBetweenLogin),

          // Facebook login
          LoginSignupButton(
            color: loginBackground,
            borderColor: loginBorder,
            buttonContent: LoginSignupButtonContent(
                svgOffset: svgOffset,
                svgPath: 'assets/login/facebook_icon.svg',
                svgDimensions: svgDimensions,
                text: 'Log in with Facebook',
                fontSize: fontSize,
                fontColor: fontColor),
            height: btnHeight,
            width: btnWidth,
            onTap: forceLogin,
          ),

          // Test out the dating profile creation flow
          SizedBox(height: spaceBetweenLogin),

          LoginSignupButton(
            color: loginBackground,
            borderColor: loginBorder,
            buttonContent: const Text(
              'Test - Profile Creation',
              style: TextStyle(
                fontSize: fontSize, 
                color: fontColor,
                fontWeight: FontWeight.w700,
              )
            ),
            
            height: btnHeight,
            width: btnWidth,
            onTap: navigateToProfileSetup,
          ),
        ],
      ),
    );
  }
}
