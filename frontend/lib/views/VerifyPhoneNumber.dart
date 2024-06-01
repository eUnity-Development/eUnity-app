import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:frontend/classes/DesignVariables.dart';
import 'package:frontend/widgets/LoginSignup/login_signup_button.dart';
import 'package:frontend/widgets/TopBars/PushedScreenTopBar.dart';
  
class VerifyPhoneNumber extends StatefulWidget {
    const VerifyPhoneNumber({super.key});

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumber();
}

class _VerifyPhoneNumber extends State<VerifyPhoneNumber> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void resend() async {
    print("clicked resend");
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PushedScreenTopBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: (40/932) * screenHeight,
          ),

          const Text(
            'Enter 6 Digit Code',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(
            height: (40/932) * screenHeight,
          ),

          OtpTextField(
            numberOfFields: 6,
            margin: EdgeInsets.symmetric(horizontal: (10/430) * screenWidth),
            fieldWidth: (46/430) * screenWidth,
            focusedBorderColor: DesignVariables.primaryRed,
            enabledBorderColor: DesignVariables.primaryRed,
            cursorColor: DesignVariables.greyLines,
            showFieldAsBox: false, 

            // runs when a code is typed in
            onCodeChanged: (String code) {
                // handle validation or checks here           
            },

            // runs when every textfield is filled
            onSubmit: (String verificationCode){
                showDialog(
                    context: context,
                    builder: (context){
                    return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                    );
                    }
                );
            },
          ),

          SizedBox(
            height: (38/932) * screenHeight,
          ),

          const Padding (
            padding: EdgeInsets.symmetric(horizontal: 21),
              child: Text(
                'We sent your phone number +1(111)111-1111 a 6 digit code. ' 
                'Please enter it here for verification purposes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ),

          SizedBox(
            height: (23/932) * screenHeight,
          ),

          LoginSignupButton(
            color: DesignVariables.primaryRed,  
            onTap: resend, 
            borderColor: Colors.transparent, 
            width: (334.67/430) * screenWidth, 
            height: (52/932) * screenHeight, 
            buttonContent: const Text(
              'Re-send Verification Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
            )
          )


        ]
      )  
      
    );
  }}