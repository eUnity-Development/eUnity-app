import 'package:flutter/material.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:numberpicker/numberpicker.dart';

class SelectionDialogHeight extends StatefulWidget {
  final VoidCallback exitFunction;
  final String cacheKey;

  const SelectionDialogHeight(
      {super.key, required this.exitFunction, required this.cacheKey});

  @override
  State<SelectionDialogHeight> createState() => _SelectionDialogHeightState();
}

class _SelectionDialogHeightState extends State<SelectionDialogHeight> {
  int currentFt = 5;
  int currentIn = 6;

  @override
  Widget build(BuildContext context) {
    void updateHeight() {
      setState(() {
        UserInfoHelper.userInfoCache[widget.cacheKey] =
            '$currentFt\' $currentIn"';
      });
      widget.exitFunction();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                const Text('Feet',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.underline)),
                NumberPicker(
                  value: currentFt,
                  minValue: 3,
                  maxValue: 7,
                  onChanged: (value) => setState(() => currentFt = value),
                  selectedTextStyle: TextStyle(
                      color: DesignVariables.primaryRed, fontSize: 24),
                  textMapper: (numberText) => '$numberText\'',
                ),
              ]),
              Column(children: [
                const Text('Inches',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.underline)),
                NumberPicker(
                  value: currentIn,
                  minValue: 0,
                  maxValue: 11,
                  haptics: true,
                  onChanged: (value) => setState(() => currentIn = value),
                  selectedTextStyle: TextStyle(
                      color: DesignVariables.primaryRed, fontSize: 24),
                  textMapper: (numberText) => '$numberText"',
                ),
              ])
            ],
          ),
          const Spacer(),
          LoginSignupButton(
              color: DesignVariables.primaryRed,
              onTap: updateHeight,
              borderColor: Colors.transparent,
              height: 40,
              width: double.infinity,
              buttonContent: const Text(
                'Save',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
