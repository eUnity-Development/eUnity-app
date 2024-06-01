import 'package:flutter/material.dart';
import 'package:frontend/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:frontend/widgets/LoginSignup/login_signup_button.dart';
import 'package:frontend/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:frontend/classes/DesignVariables.dart';


class PasswordSignup extends StatelessWidget {
  const PasswordSignup({super.key});

  

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double btnWidth = (334.67/430) * screenWidth;
    final double btnHeight = (52/932) * screenHeight;

    final double svgOffset = (20/430) * screenWidth; 
    const double svgDimensions = 27;
    const double fontSize = 16.5;
    const Color fontColor = Color.fromRGBO(0, 0, 0, 0.5);

        void testSignup() async {
              print("clicked signup");
        }

    return Scaffold(
      appBar: const PushedScreenTopBar(
      ),
 body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Password',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Your Password...",
                      fillColor: Colors.white70,
                      
                    ),
                    obscureText: true,
                  ),
            const Spacer(),
             SizedBox(
            height: ((73/932) * screenHeight)
          ),

          // Sign up
          LoginSignupButton(
            color: DesignVariables.primaryRed,
            borderColor: Colors.transparent,
            buttonContent: LoginSignupButtonContent(
              svgOffset: svgOffset, 
              svgPath: 'assets/NavBarUI/arrow-long-left.svg', 
              svgDimensions: svgDimensions, 
              text: 'Next', 
              fontSize: fontSize, 
              fontColor: Colors.white,
              ),
            
            height: btnHeight,
            width: btnWidth,
            //to be changed when backend functionality is added
            onTap: () => null,

          ),
                  ],
                ),
              ),
            );
  }
}



