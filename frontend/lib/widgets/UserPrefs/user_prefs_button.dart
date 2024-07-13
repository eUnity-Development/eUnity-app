import 'package:eunity/widgets/NameDOBGender/birthday_classes.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionFunction.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserPrefsButton extends StatefulWidget {
  final String name;
  final BuildContext context;
  final List<String> options;
  final String question;
  final String assetPath;
  final String cacheKey;
  final bool multiSelect;

  const UserPrefsButton(
    {super.key,
    required this.name,
    required this.context,
    required this.options,
    required this.question,
    required this.assetPath,
    required this.cacheKey,
    required this.multiSelect,
    });

  @override
  State<StatefulWidget> createState() {
    return UserPrefsButtonState();
  }
}

class UserPrefsButtonState extends State<UserPrefsButton> {
  String action = '';

  void update() {
    action = UserInfoHelper.userInfoCache[widget.cacheKey];
    setState(() {
      action = UserInfoHelper.userInfoCache[widget.cacheKey];
    });
  }

  @override
  Widget build(BuildContext context) {
    action = UserInfoHelper.userInfoCache[widget.cacheKey];
    String button_name = widget.name;
    return(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/preferences/user-group.svg',
            height: 20,
            width: 20,
          ),
          BoxGap(width: 9 * DesignVariables.widthConversion, height: 0),
          Text(button_name, style: const TextStyle(fontSize: 18)),

          const Spacer(),

          GestureDetector(
            onTap: () => showSelectDialog(
              reRender: update,
              context: widget.context,
              options: widget.options,
              cacheKey: widget.cacheKey,
              question: widget.question,
              // assetPath is the svg for the question in selection dialog option
              assetPath: widget.assetPath,
              multiSelect: widget.multiSelect,
            ),
            child: Row(
              children: [
                // Set up like the non-binary gender option, pull from userInfoHelper!
                Text(action, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                BoxGap(width: 15 * DesignVariables.widthConversion, height: 0),
                SvgPicture.asset(
                  'assets/preferences/arrow-right.svg',
                  height: 20,
                  width: 20,
                ),
              ],),
          ),
        ],
      )
    );
  }
}