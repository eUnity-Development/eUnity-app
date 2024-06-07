import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NameDOBGender extends StatefulWidget {
  const NameDOBGender({super.key});

  @override
  State<NameDOBGender> createState() => _NameDOBGender();
}

class _NameDOBGender extends State<NameDOBGender> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PushedScreenTopBar(hasArrow: false),
      body: Padding(     
        padding: EdgeInsets.symmetric(horizontal: 18.0 * DesignVariables.widthConversion), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  labelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48 * DesignVariables.heightConversion,
                  width: 95.53 * DesignVariables.widthConversion,
                  decoration: BoxDecoration(
                      border: Border.all(color: DesignVariables.greyLines, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Row(
                    children: [
                      Expanded(
                      
                      child: Center(child: TextField( 
                        controller: _monthController,
                        
                        decoration: const InputDecoration(
                          hintText: 'M',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 13),
                        ),

                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                      ))),
                      
                      Expanded(
                      child: TextField( 
                        controller: _monthController,
                  
                        decoration: const InputDecoration(
                          hintText: 'M',
                          contentPadding: EdgeInsets.only(bottom: 13),
                          border: InputBorder.none,
                        ),

                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                      )
                      )
                      
                    ],
                  )
                )
    
              ],
            ),

            
          ]
      ))

    );
  }
}