import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:frontend/classes/DesignVariables.dart';
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PushedScreenTopBar(),
      body:  OtpTextField(
        numberOfFields: 6,
        margin: EdgeInsets.only(right: (10/430) * screenWidth, left: (10/430) * screenWidth),
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
    );
  }}