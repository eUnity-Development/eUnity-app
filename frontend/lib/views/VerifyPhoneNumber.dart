import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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
      return Scaffold(
        appBar: const PushedScreenTopBar(),
        body:     OtpTextField(
        numberOfFields: 5,
        borderColor: Color(0xFF512DA8),
        //set to true to show as box or false to show as dash
        showFieldAsBox: true, 
        //runs when a code is typed in
        onCodeChanged: (String code) {
            //handle validation or checks here           
        },
        //runs when every textfield is filled
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
        }, // end onSubmit
    ),
      );
  }}