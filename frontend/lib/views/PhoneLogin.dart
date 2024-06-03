import 'package:flutter/material.dart';
import 'package:frontend/classes/DesignVariables.dart';
import 'package:frontend/views/VerifyPhoneNumber.dart';
import 'package:frontend/widgets/LoginSignup/login_signup_button.dart';
import 'package:frontend/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _enteredPhoneNumber;

  @override
  void dispose() {
    _phoneController.dispose();
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
      body: MainStack(screenHeight, screenWidth, btnWidth, btnHeight),
    );
  }

  Stack MainStack(
    double screenHeight,
    double screenWidth,
    double btnWidth,
    double btnHeight,
  ) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: DesignVariables.primaryRed,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 60,
                left: 12.0,
                right: 8.0,
              ),
              child: Center(
                child: Text(
                  'eUnity is glad to see you back. Please, '
                  'enter the phone number you '
                  'linked with your account in order to log-in.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Center(
              child: EnterNumberTextField(),
            ),
          ],
        ),
        Positioned(
          bottom: (50 / 932) * screenHeight, // Distance from the bottom of the screen
          left: (screenWidth - btnWidth) / 2, // Center the button horizontally
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
        )
      ],
    );
  }

  Column EnterNumberHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 60.0,
            bottom: 60.0,
            left: 12.0,
            right: 12.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'eUnity is glad to see you back. Please, '
                'enter the phone number you '
                'linked with your account in order to log-in.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Center EnterNumberTextField() {
    return Center(
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: 400,
          child: IntlPhoneField(
            controller: _phoneController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            onChanged: (phone) {
              setState(() {
                _enteredPhoneNumber = phone.completeNumber;
              });
            },
            validator: (phone) {
              if (phone == null ||
                  phone.number.isEmpty ||
                  !phone.isValidNumber()) {
                return 'Invalid Mobile Number';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(52),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(52),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.9),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(52),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.2,
                  style: BorderStyle.solid,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(52),
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.8),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.all(16),
              fillColor: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

void navigateToPrimaryScreens() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VerifyPhoneNumber(phoneNumber: _enteredPhoneNumber,)),
    );
  }

  void nextScreen() async {
    if (_formKey.currentState?.validate() == true) {
      // Navigate to the next screen
      print(_enteredPhoneNumber);
      navigateToPrimaryScreens();
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid phone number'),
        ),
      );
    }
  }
}