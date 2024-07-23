import 'package:flutter/material.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';

class SelectionDialogEnterText extends StatefulWidget {
  final String cacheKey;
  final String labelString;
  const SelectionDialogEnterText(
      {super.key,
      required this.cacheKey,
      required this.labelString
      });

  @override
  State<SelectionDialogEnterText> createState() => _SelectionDialogEnterTextState();
  
}

class _SelectionDialogEnterTextState extends State<SelectionDialogEnterText> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController.text = UserInfoHelper.userInfoCache[widget.cacheKey] == 'Enter'
      ? '' : UserInfoHelper.userInfoCache[widget.cacheKey];

      void updateCache(String value) {
        setState(() {
          if (value != '') {
            UserInfoHelper.userInfoCache[widget.cacheKey] = value;
          } else {
            UserInfoHelper.userInfoCache[widget.cacheKey] = 'Enter';
          }
        });
      }

    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: TextField(
              controller: _textController,
              onSubmitted: updateCache,
              decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 19 * DesignVariables.heightConversion,
                              horizontal: 15 * DesignVariables.widthConversion
                            ),
                            labelText: widget.labelString,
                            labelStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18,
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
                          ),
            )
          );
  }
}