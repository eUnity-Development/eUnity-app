import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/AuthHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/CoreTemplate.dart';
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
        navigateToPrimaryScreens();
      }
    });

    //when we detect user change we trigger this function
    AuthHelper.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      GoogleSignInAuthentication? auth = await account?.authentication;
      // print(account);
      // print("Google Sign In");
      // print(auth);
      // print(auth?.idToken);
      if (auth != null) {
        String googleKey = auth.idToken!;
        Response res = await AuthHelper.verifyGoogleIDToken(googleKey);
        if (res.statusCode == 200) {
          navigateToPrimaryScreens();
        }
      }


    });


    //try to login silently on app load
    AuthHelper.googleSignIn.signInSilently();
  }

  void navigateToPrimaryScreens() {
    print("Navigating to primary screens");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CoreTemplate()),
        (route) => false);
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
    //var response = await AuthHelper.signUp("testemail@test.com", "Test123123");
    //print(response);
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double btnWidth = (334.67 / 430) * screenWidth;
    final double btnHeight = (52 / 932) * screenHeight;

    final double svgOffset = (20 / 430) * screenWidth;
    const double svgDimensions = 27;
    const double fontSize = 16.5;
    const Color fontColor = Color.fromRGBO(0, 0, 0, 0.5);

    final Color loginBorder = DesignVariables.greyLines;
    const Color loginBackground = Colors.transparent;

    final double spaceBetweenLogin = ((31 / 932) * screenHeight);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: const AssetImage('assets/e-unity-logo-and-name.png'),
              width: ((330 / 430) * screenWidth),
              height: ((118.75 / 932) * screenHeight),
            ),
          ),

          SizedBox(
            height: ((45 / 932) * screenHeight),
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

          SizedBox(height: ((73 / 932) * screenHeight)),
          /*
          // Sign up
          LoginSignupButton(
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            buttonContent: const Text(
              "Sign Up Here!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
            height: btnHeight,
            width: btnWidth,
            onTap: testSignup,
          ),
          
          SizedBox(
            height: ((92/932) * screenHeight)
          ),

          // Email login
          LoginSignupButton(
            color: loginBackground,
            borderColor: loginBorder,
            buttonContent: LoginSignupButtonContent(
              svgOffset: svgOffset, 
              svgPath: 'assets/login/envelope.svg', 
              svgDimensions: svgDimensions, 
              text: 'Log in with email', 
              fontSize: fontSize, 
              fontColor: fontColor
            ),
            
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),

          SizedBox(
            height: spaceBetweenLogin
          ),*/

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
        ],
      ),
    );
  }
}
