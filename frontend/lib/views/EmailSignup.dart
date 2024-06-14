import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/PasswordSignup.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';

class EmailSignup extends StatefulWidget {
  const EmailSignup({super.key});

  @override
  State<EmailSignup> createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double btnWidth = (334.67 / 430) * screenWidth;
    final double btnHeight = (52 / 932) * screenHeight;

    return Scaffold(
      appBar: PushedScreenTopBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 180),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EnterEmailHeader(),
                  EnterEmailTextField(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: (50 / 932) *
                screenHeight, // Distance from the bottom of the screen
            left:
                (screenWidth - btnWidth) / 2, // Center the button horizontally
            child: LoginSignupButton(
              color: DesignVariables.primaryRed,
              borderColor: Colors.transparent,
              buttonContent: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
              height: btnHeight,
              width: btnWidth,
              onTap: nextScreen,
            ),
          ),
        ],
      ),
    );
  }

  Padding EnterEmailHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter Email',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Center EnterEmailTextField() {
    return Center(
      child: SizedBox(
        width: 400,
        child: TextField(
          controller: _emailController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
            hintText: 'Your Email...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(52),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.5), // Adjust opacity here
                width: 1.0, // Change width as needed
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(52),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.9), // Adjust opacity here
                width: 1.0, // Change width as needed
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(52),
              borderSide: BorderSide(
                color: Colors.black, // Adjust opacity here
                width: 1.2, // Change width as needed
                style: BorderStyle.solid,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(52),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.8), // Adjust opacity here
                width: 1.0, // Change width as needed
                style: BorderStyle.solid,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }

  void navigateToPasswordSignup() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => PasswordSignup(email: _emailController.text)),
        (route) => false);
  }

  void nextScreen() async {
    navigateToPasswordSignup();
  }
}
