import 'package:flutter/material.dart';
import 'package:frontend/classes/AuthHelper.dart';
import 'package:frontend/classes/DesignVariables.dart';
import 'package:frontend/views/CoreTemplate.dart';
import 'package:frontend/views/PhoneLogin.dart';
import 'package:frontend/widgets/LoginSignup/login_signup_button.dart';
import 'package:frontend/widgets/LoginSignup/login_signup_button_content.dart';

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
  }

  void navigateToPrimaryScreens() {
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

    final double btnWidth = (334.67/430) * screenWidth;
    final double btnHeight = (52/932) * screenHeight;

    final double svgOffset = (20/430) * screenWidth; 
    const double svgDimensions = 27;
    const double fontSize = 16.5;
    const Color fontColor = Color.fromRGBO(0, 0, 0, 0.5);

    final Color loginBorder = DesignVariables.greyLines;
    const Color loginBackground = Colors.transparent;

    final double spaceBetweenLogin = ((31/932) * screenHeight);

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
              fontColor: fontColor
            ),
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),

          SizedBox(
            height: spaceBetweenLogin
          ),

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
              fontColor: fontColor
            ),
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),

          SizedBox(
            height: spaceBetweenLogin
          ),

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
              fontColor: fontColor
            ),
            height: btnHeight,
            width: btnWidth,
            onTap: testLogin,
          ),
        ],
      ),
    );
  }
}
