import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionDialog.dart';

class SelectionButton extends StatefulWidget {
  final String cacheKey;
  final String cacheObject;
  final List options;
  final String question;
  final String assetPath;
  final bool multiSelect;
  final bool allowNull;
  const SelectionButton({
    super.key,
    required this.cacheKey,
    required this.cacheObject,
    required this.options,
    required this.question,
    required this.assetPath,
    required this.multiSelect,
    required this.allowNull,
  });

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  void showSelectDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return SelectionDialog(
            options: widget.options,
            question: widget.question,
            assetPath: widget.assetPath,
            cacheKey: widget.cacheKey,
            cacheObject: widget.cacheObject,
            multiSelect: widget.multiSelect,
            allowNull: widget.allowNull,
          );
        }).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String varToText(var input) {
      String newInput = input.toString();
      if (newInput.startsWith('[') && newInput.endsWith(']')) {
        newInput = newInput.substring(1, newInput.length - 1);
      }
      return newInput;
    }

    String getDisplayValue() {
      if (widget.cacheObject != '') {
        if (UserInfoHelper.userInfoCache[widget.cacheObject][widget.cacheKey]
                .runtimeType !=
            String) {
          return varToText(UserInfoHelper.userInfoCache[widget.cacheObject]
              [widget.cacheKey]);
        }
        return UserInfoHelper.userInfoCache[widget.cacheObject]
            [widget.cacheKey];
      } else {
        if (UserInfoHelper.userInfoCache[widget.cacheKey].runtimeType !=
            String) {
          return varToText(UserInfoHelper.userInfoCache[widget.cacheKey]);
        }
        return UserInfoHelper.userInfoCache[widget.cacheKey];
      }
    }

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
            border: Border.all(color: DesignVariables.greyLines, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                getDisplayValue(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color.fromARGB(128, 0, 0, 0),
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        showSelectDialog(context);
      },
    );
  }
}
