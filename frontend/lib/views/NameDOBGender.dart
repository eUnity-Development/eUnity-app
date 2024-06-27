import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:eunity/widgets/NameDOBGender/birthday_classes.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionFunction.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';

import '../widgets/LoginSignup/login_signup_button.dart';

class NameDOBGender extends StatefulWidget {
  const NameDOBGender({super.key});

  @override
  State<NameDOBGender> createState() => _NameDOBGender();
}

class _NameDOBGender extends State<NameDOBGender> {
  final TextEditingController _nameController = TextEditingController();

  final List<TextEditingController> _dobControllers = List<TextEditingController>.generate(8, (int index) => TextEditingController());
  final List<FocusNode> _dobFocusNodes = List<FocusNode>.generate(8, (int index) => FocusNode());

  // Month, day, and year indices for _dobControllers and _dobFocusNodes
  int m1 = 0, m2 = 1, d1 = 2, d2 = 3, y1 = 4, y2 = 5, y3 = 6, y4 = 7;

  // Index determines which gender is selected
  int activeButtonIndex = -1;
  String nonBinaryButtonText = 'Non-Binary';
  List<String> genderOptions = [];

  // Button that the user selects is the 'active' button
  void setActiveButtonIndex(int index) {
    setState(() {
      activeButtonIndex = index;
      UserInfoHelper.userInfoCache['userGender'] = genderOptions[index];
    });
  }

  // Update Non-Binary button text after selection
  void updateNonBinaryGender() {
    setState(() {
      nonBinaryButtonText = UserInfoHelper.userInfoCache['userGenderOptions'] ?? 'Non-Binary';
    });
  }

  // OnTap for Non-Binary button so it works w/ selection pop-up
  void selectNonBinary() {
    showSelectDialog(
      reRender: updateNonBinaryGender,
      context: context,
      options: ['Agender', 'Gender Fluid', 'Non-Binary'], // Add more genders here
      cacheKey: 'userGenderOptions',
      question: 'Select your gender',
      assetPath: 'None',
      multiSelect: false,
    );
    UserInfoHelper.userInfoCache['userGender'] = UserInfoHelper.userInfoCache['userGenderOptions'];
    setActiveButtonIndex(2);
  }

  void onNext() {
    print('Pressed next button');
  }

  @override
  void dispose() {
    for (int i = 0; i < 8; i++) {
      _dobControllers[i].dispose();
      _dobFocusNodes[i].dispose();
    }
    _nameController.dispose();
    super.dispose();
  }

    // When backspacing on empty field, it should move back to previous field
    void handleBackspace() {
      for (int i = 0; i < _dobControllers.length; i++) {
        if (_dobFocusNodes[i].hasFocus && _dobControllers[i].text.isEmpty && i > 0) {
          _dobFocusNodes[i - 1].requestFocus();
          break;
        }
      }
    }
    
    // When typing anything into a filled field, it should move to next field
    void handleKeyPress() {
      for (int i = 0; i < _dobControllers.length; i++) {
        if (_dobFocusNodes[i].hasFocus && _dobControllers[i].text.isNotEmpty && i < _dobControllers.length - 1) {
          _dobFocusNodes[i + 1].requestFocus();
          break;
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    genderOptions  = ['Man', 'Woman', nonBinaryButtonText];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      // Navbar
      appBar: const PushedScreenTopBar(hasArrow: false),
      body: Padding(     
        padding: EdgeInsets.symmetric(horizontal: 18.0 * DesignVariables.widthConversion), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Name header
            const Text(
              "Name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const BoxGap(width: 0, height: 7),

            // Name description
            const Text(
              "The name you enter here will appear on your profile.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            const BoxGap(width: 0, height: 30),

            // Name textfield
            Center(
              child: SizedBox(
                height: 48 * DesignVariables.heightConversion,
                width: 393 * DesignVariables.widthConversion,
                child: TextField( 
                  controller: _nameController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                 textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 19 * DesignVariables.heightConversion,
                      horizontal: 15 * DesignVariables.widthConversion
                    ),
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: DesignVariables.greyLines,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: DesignVariables.greyLines,
                        width: 1,
                      ),
                    ),
                  )
                )
              )
            ),

            const BoxGap(width: 0, height: 29),

            // Birthday header
            const Text(
              "Birthday",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const BoxGap(width: 0, height: 7),

            // Birthday description
            const Text(
              "We will need your date of birth to confirm your age.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            const BoxGap(width: 0, height: 30),

            KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (value) => {
              if (value.logicalKey.keyLabel == 'Backspace') {
                handleBackspace()
              } else {
                handleKeyPress()
              }
            },
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Month section
              DOBSection(
              width: 95.53 * DesignVariables.widthConversion, 
              height: 48 * DesignVariables.heightConversion, 
              inputs: [
                IndividualTextField(
                  controller: _dobControllers[m1], 
                  hintText: 'M',
                  focusNode: _dobFocusNodes[m1],
                  nextFocusNode: _dobFocusNodes[m2],
                ),
                const SizedBox(width: 10),
                IndividualTextField(
                  controller: _dobControllers[m2], 
                  hintText: 'M',
                  focusNode: _dobFocusNodes[m2],
                  nextFocusNode: _dobFocusNodes[d1],
                )
              ]
            ),

            const BoxGap(width: 12, height: 0),

            Text(
              "/",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5), 
                fontSize: 24,
              ),
              
            ),

            const BoxGap(width: 12, height: 0),

            // Day section
            DOBSection(
              width: 95.53 * DesignVariables.widthConversion, 
              height: 48 * DesignVariables.heightConversion, 
              inputs: [
                IndividualTextField(
                  controller: _dobControllers[d1], 
                  hintText: 'D',
                  focusNode: _dobFocusNodes[d1],
                  nextFocusNode: _dobFocusNodes[d2],
                ),
                const SizedBox(width: 10),
                IndividualTextField(
                  controller: _dobControllers[d2], 
                  hintText: 'D',
                  focusNode: _dobFocusNodes[d2],
                  nextFocusNode: _dobFocusNodes[y1],
                )
              ]
            ),

            const BoxGap(width: 12, height: 0),

            Text(
              "/",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5), 
                fontSize: 24,
              ),
              
            ),

            const BoxGap(width: 12, height: 0),

            // Year section
            DOBSection(
              width: 127.92 * DesignVariables.widthConversion, 
              height: 48 * DesignVariables.heightConversion, 
              inputs: [
                IndividualTextField(
                  controller: _dobControllers[y1], 
                  hintText: 'Y',
                  focusNode: _dobFocusNodes[y1],
                  nextFocusNode:  _dobFocusNodes[y2],
                ),
                const BoxGap(width: 10, height: 0),
                IndividualTextField(
                  controller: _dobControllers[y2], 
                  hintText: 'Y',
                  focusNode:  _dobFocusNodes[y2],
                  nextFocusNode:  _dobFocusNodes[y3],
                ),
                const BoxGap(width: 10, height: 0),
                IndividualTextField(
                  controller: _dobControllers[y3], 
                  hintText: 'Y',
                  focusNode:  _dobFocusNodes[y3],
                  nextFocusNode:  _dobFocusNodes[y4],
                ),
                const BoxGap(width: 10, height: 0),
                IndividualTextField(
                  controller: _dobControllers[y4], 
                  hintText: 'Y',
                  focusNode:  _dobFocusNodes[y4],
                ),
                ]
              ), 
            ],
        
          )),
        
          const BoxGap(width: 0, height: 29),

          // Gender header
          const Text(
            "Gender",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const BoxGap(width: 0, height: 7),

          // Gender description
          const Text(
            "Pick a gender you identify the most with.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const BoxGap(width: 0, height: 30),

          // Gender selection: Man - Index 0
          LoginSignupButton(
            color: Colors.transparent,
            onTap: () => setActiveButtonIndex(0),
            borderColor: activeButtonIndex == 0 ? 
              DesignVariables.primaryRed : DesignVariables.greyLines,
            height: 48 * DesignVariables.heightConversion,
            width: 393 * DesignVariables.widthConversion,
            buttonContent: Text(
              genderOptions[0],
              style: TextStyle(
                color: activeButtonIndex == 0 ? 
                  DesignVariables.primaryRed : Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
            ),
          ),

          const BoxGap(width: 0, height: 13),

          // Gender selection: Woman - Index 1
          LoginSignupButton(
            color: Colors.transparent,
            onTap: () => setActiveButtonIndex(1),
            borderColor: activeButtonIndex == 1 ? 
              DesignVariables.primaryRed : DesignVariables.greyLines,
            height: 48 * DesignVariables.heightConversion,
            width: 393 * DesignVariables.widthConversion,
            buttonContent: Text(
              genderOptions[1],
              style: TextStyle(
                color: activeButtonIndex == 1 ? 
                  DesignVariables.primaryRed : Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
            ),
          ),

          const BoxGap(width: 0, height: 13),

          // Gender selection: Non-Binary - Index 2
          LoginSignupButton(
            color: Colors.transparent,
            onTap: () => selectNonBinary(),
            borderColor: activeButtonIndex == 2 ? 
              DesignVariables.primaryRed : DesignVariables.greyLines,
            height: 48 * DesignVariables.heightConversion,
            width: 393 * DesignVariables.widthConversion,
            buttonContent: LoginSignupButtonContent(
              svgOffset: 15 * DesignVariables.widthConversion, 
              svgPath: activeButtonIndex == 2 ? 
                'assets/icons/chevron-right-select.svg' : 'assets/icons/chevron-right.svg', 
              svgDimensions: 20, 
              text: nonBinaryButtonText,
              fontSize: 14, 
              fontColor: activeButtonIndex == 2 ? 
                DesignVariables.primaryRed : Colors.black.withOpacity(0.5),
              isRight: true,
              fontWeight: FontWeight.w500,            
            )
          ),

          const Spacer(),

          LoginSignupButton(
            color: DesignVariables.primaryRed, 
            onTap: onNext, 
            borderColor: Colors.transparent, 
            height: 52 * DesignVariables.heightConversion, 
            width: 334.67 * DesignVariables.widthConversion, 
            buttonContent: 
              LoginSignupButtonContent(
                svgOffset: 18 * DesignVariables.widthConversion,
                svgPath: 'assets/icons/arrow-long-left.svg',
                svgDimensions: 36,
                text: 'Next',
                fontSize: 22,
                fontColor: Colors.white,
                isRight: true,
                fontWeight: FontWeight.w700,
              )
          ),

          const BoxGap(width: 0, height: 36),
        ],
          
      ))
    );
  }
}