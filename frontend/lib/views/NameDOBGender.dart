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
  final TextEditingController _monthOneController = TextEditingController();
  final TextEditingController _monthTwoController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
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
                      Container(
                        width: 14,
                        color: Colors.blue,
                        child: TextField( 
                          controller: _monthOneController,
                          //focusNode: _focusNode,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            hintText: 'M',
                          
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          ),

                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                        )

                      ),

                      const SizedBox(width: 14),

                      Container(
                        width: 14,
                        color: Colors.blue,
                        child: TextField( 
                          controller: _monthTwoController,
                          //focusNode: _focusNode,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            hintText: 'M',
                          
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          ),

                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                        )
                      ),
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