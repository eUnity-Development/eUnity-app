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

  final TextEditingController _monthController1 = TextEditingController();
  final TextEditingController _monthController2 = TextEditingController();

  final TextEditingController _dayController1 = TextEditingController();
  final TextEditingController _dayController2 = TextEditingController();

  final TextEditingController _yearController1 = TextEditingController();
  final TextEditingController _yearController2 = TextEditingController();
  final TextEditingController _yearController3 = TextEditingController();
  final TextEditingController _yearController4 = TextEditingController();

  final FocusNode _monthFocus1 = FocusNode();
  final FocusNode _monthFocus2 = FocusNode();

  final FocusNode _dayFocus1 = FocusNode();
  final FocusNode _dayFocus2 = FocusNode();

  final FocusNode _yearFocus1 = FocusNode();
  final FocusNode _yearFocus2 = FocusNode();
  final FocusNode _yearFocus3 = FocusNode();
  final FocusNode _yearFocus4 = FocusNode();

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
      options: ['Agender', 'Gender Fluid', 'Non-Binary'],
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
    _nameController.dispose();
    _monthController1.dispose();
    _monthController2.dispose();
    _dayController1.dispose();
    _dayController2.dispose();
    _yearController1.dispose();
    _yearController2.dispose();
    _yearController3.dispose();
    _yearController4.dispose();

    _monthFocus1.dispose();
    _monthFocus2.dispose();
    _dayFocus1.dispose();
    _dayFocus2.dispose();
    _yearFocus1.dispose();
    _yearFocus2.dispose();
    _yearFocus3.dispose();
    _yearFocus4.dispose();

    super.dispose();
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Month section
              DOBSection(
              width: 95.53 * DesignVariables.widthConversion, 
              height: 48 * DesignVariables.heightConversion, 
              inputs: [
                IndividualTextField(
                  controller: _monthController1, 
                  hintText: 'M',
                  focusNode: _monthFocus1,
                  nextFocusNode: _monthFocus2,
                ),
                const SizedBox(width: 10),
                IndividualTextField(
                  controller: _monthController2, 
                  hintText: 'M',
                  focusNode: _monthFocus2,
                  nextFocusNode: _dayFocus1,
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
                  controller: _dayController1, 
                  hintText: 'D',
                  focusNode: _dayFocus1,
                  nextFocusNode: _dayFocus2,
                ),
                const SizedBox(width: 10),
                IndividualTextField(
                  controller: _dayController2, 
                  hintText: 'D',
                  focusNode: _dayFocus2,
                  nextFocusNode: _yearFocus1,
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
                  controller: _yearController1, 
                  hintText: 'Y',
                  focusNode: _yearFocus1,
                  nextFocusNode: _yearFocus2,
                ),
                const BoxGap(width: 10, height: 0),
                IndividualTextField(
                  controller: _yearController2, 
                  hintText: 'Y',
                  focusNode: _yearFocus2,
                  nextFocusNode: _yearFocus3,
                ),
                const BoxGap(width: 10, height: 0),
                IndividualTextField(
                  controller: _yearController3, 
                  hintText: 'Y',
                  focusNode: _yearFocus3,
                  nextFocusNode: _yearFocus4,
                ),
                const BoxGap(width: 10, height: 0),
                IndividualTextField(
                  controller: _yearController4, 
                  hintText: 'Y',
                  focusNode: _yearFocus4,
                ),
                ]
              ), 
            ],
        
          ),
        
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