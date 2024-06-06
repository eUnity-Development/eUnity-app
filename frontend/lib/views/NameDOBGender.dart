import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';

class NameDOBGender extends StatefulWidget {
  const NameDOBGender({super.key});

  @override
  State<NameDOBGender> createState() => _NameDOBGender();
}

class _NameDOBGender extends State<NameDOBGender> {
  final TextEditingController _nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PushedScreenTopBar(hasArrow: false),
      body: Padding(     
        padding: EdgeInsets.symmetric(horizontal: 18.0), 
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

            Container(
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: DesignVariables.greyLines
                    ),
                  ),
                )
              )
            )

            
          ]
      ))

    );
  }
}