import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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

  void onClick() {
    print('CLICKED!');
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

            SizedBox(
              height: 7 * DesignVariables.heightConversion,
            ),

            // Name description
            const Text(
              "The name you enter here will appear on your profile.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(
              height: 30 * DesignVariables.heightConversion,
            ),

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

            SizedBox(
              height: 29 * DesignVariables.heightConversion,
            ),

            // Birthday header
            const Text(
              "Birthday",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(
              height: 7 * DesignVariables.heightConversion,
            ),

            // Birthday description
            const Text(
              "We will need your date of birth to confirm your age.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(
              height: 30 * DesignVariables.heightConversion,
            ),

            Row(children: [
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

            SizedBox(
              width: 12 * DesignVariables.widthConversion,
            ),

            Text(
              "/",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5), 
                fontSize: 24,
              ),
              
            ),

            SizedBox(
              width: 12 * DesignVariables.widthConversion,
            ),

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

            SizedBox(
              width: 12 * DesignVariables.widthConversion,
            ),

            Text(
              "/",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5), 
                fontSize: 24,
              ),
              
            ),

            SizedBox(
              width: 12 * DesignVariables.widthConversion,
            ),

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
                const SizedBox(width: 10),
                IndividualTextField(
                  controller: _yearController2, 
                  hintText: 'Y',
                  focusNode: _yearFocus2,
                  nextFocusNode: _yearFocus3,
                ),
                const SizedBox(width: 10),
                IndividualTextField(
                  controller: _yearController3, 
                  hintText: 'Y',
                  focusNode: _yearFocus3,
                  nextFocusNode: _yearFocus4,
                ),
                const SizedBox(width: 10),
                IndividualTextField(
                  controller: _yearController4, 
                  hintText: 'Y',
                  focusNode: _yearFocus4,
                ),
              ]
            ), 
          ],
          
          
        ),
        
          SizedBox(
            height: 29 * DesignVariables.heightConversion,
          ), 

          // Gender header
          const Text(
            "Gender",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(
            height: 7 * DesignVariables.heightConversion,
          ),

          // Gender description
          const Text(
            "Pick a gender you identify the most with.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(
            height: 30 * DesignVariables.heightConversion,
          ),

          // Gender selection: man
          LoginSignupButton(
            color: Colors.transparent,
            onTap: onClick,
            borderColor: DesignVariables.greyLines,
            height: 48 * DesignVariables.heightConversion,
            width: 393 * DesignVariables.widthConversion,
            buttonContent: Text(
              'Man',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
            ),
          ),

          SizedBox(
            height: 13 * DesignVariables.heightConversion,
          ),

          // Gender selection: woman
          LoginSignupButton(
            color: Colors.transparent,
            onTap: onClick,
            borderColor: DesignVariables.greyLines,
            height: 48 * DesignVariables.heightConversion,
            width: 393 * DesignVariables.widthConversion,
            buttonContent: Text(
              'Woman',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
            ),
          ),

          SizedBox(
            height: 13 * DesignVariables.heightConversion,
          ),

          // Gender selection: more options
          LoginSignupButton(
            color: Colors.transparent,
            onTap: onClick,
            borderColor: DesignVariables.greyLines,
            height: 48 * DesignVariables.heightConversion,
            width: 393 * DesignVariables.widthConversion,
            buttonContent: LoginSignupButtonContent(
              svgOffset: 15 * DesignVariables.widthConversion, 
              svgPath: 'assets/icons/chevron-right.svg', 
              svgDimensions: 20, 
              text: 'More Options', 
              fontSize: 14, 
              fontColor: Colors.black.withOpacity(0.5),
              isRight: true,
              fontWeight: FontWeight.w500,            
            )
          ),
        ],
          
      ))
    );
  }
}

class DOBSection extends StatelessWidget {
  final double width;
  final double height;
  final List<Widget> inputs;

  const DOBSection({
    super.key,
    required this.width,
    required this.height,
    required this.inputs
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height,
          width: width,
          
          decoration: BoxDecoration(
              border: Border.all(color: DesignVariables.greyLines, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: inputs,
          )
        )

      ],
    );
  }
}

class IndividualTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const IndividualTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    this.nextFocusNode,
  });

  @override
  _IndividualTextFieldState createState() => _IndividualTextFieldState();
}

class _IndividualTextFieldState extends State<IndividualTextField> {
  late String _currentHintText;

  @override
  void initState() {
    super.initState();
    _currentHintText = widget.hintText;
    widget.focusNode.addListener(_updateHintText);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_updateHintText);
    super.dispose();
  }

  void _updateHintText() {
    setState(() {
      _currentHintText = widget.focusNode.hasFocus ? '' : widget.hintText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      child: Stack(
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            style: const TextStyle(fontSize: 14),
            maxLength: 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 2),
              hintText: _currentHintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              border: InputBorder.none,
            ),

            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,

            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.nextFocusNode?.requestFocus();
              } else if (value.isEmpty) {
                widget.focusNode.previousFocus();
              }
            },

          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            child: Divider(color: Colors.black.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}