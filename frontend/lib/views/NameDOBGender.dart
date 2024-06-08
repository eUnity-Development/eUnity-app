import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NameDOBGender extends StatefulWidget {
  const NameDOBGender({super.key});

  @override
  State<NameDOBGender> createState() => _NameDOBGender();
}

class _NameDOBGender extends State<NameDOBGender> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _monthController1 = TextEditingController();
  final TextEditingController _monthController2 = TextEditingController();

  @override
  void dispose() {
    _monthController1.dispose();
    _monthController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )),

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

            // Month section
            DOBSection(
              width: 95.53 * DesignVariables.widthConversion, 
              height: 48 * DesignVariables.heightConversion, 
              inputs: [
                InidividualTextField(controller: _monthController1, hintText: 'M'),
                const SizedBox(width: 10),
                InidividualTextField(controller: _monthController2, hintText: 'M')
              ]
            )
      ]
      )

    )
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

class InidividualTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const InidividualTextField({
    super.key,
    required this.controller,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      child: Stack(
        children: [
          TextField(
            style: const TextStyle(fontSize: 14),
            maxLength: 1, 
            controller: controller,
            
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 2),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              border: InputBorder.none,
            ),

            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,

          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            child: Divider(
              color: Colors.black.withOpacity(0.5)
            ),
          ),

        ],
      )

    );
  }

}