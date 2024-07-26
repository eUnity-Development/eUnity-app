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
  final bool isLongList;

  const UserPrefsButton(
    {super.key,
    required this.name,
    required this.context,
    required this.options,
    required this.question,
    required this.assetPath,
    required this.cacheKey,
    required this.multiSelect,
    required this.isLongList,
    });

  @override
  State<StatefulWidget> createState() {
    return UserPrefsButtonState();
  }
}

class UserPrefsButtonState extends State<UserPrefsButton> {
  String action = '';
  String staticText = 'Add';

  void update() {
    setState(() {
      if (widget.multiSelect && UserInfoHelper.userInfoCache[widget.cacheKey].length > 0) {
        staticText = 'Edit';
      }
      action = widget.multiSelect ? staticText : UserInfoHelper.userInfoCache[widget.cacheKey];
    });
  }

  @override
  Widget build(BuildContext context) {
    action = widget.multiSelect ? staticText : UserInfoHelper.userInfoCache[widget.cacheKey];
    String buttonName = widget.name;
    return(
      Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.assetPath,
              height: 20,
              width: 20,
            ),
            BoxGap(width: 9 * DesignVariables.widthConversion, height: 0),

            Text(buttonName, style: const TextStyle(fontSize: 18)),

            const Spacer(),

            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => showSelectDialog(
                reRender: update,
                context: widget.context,
                options: widget.options,
                cacheKey: widget.cacheKey,
                question: widget.question,
                assetPath: widget.assetPath,
                multiSelect: widget.multiSelect,
                isListLong: widget.isLongList
              ),

              child: Row(
                children: [
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
        ),
        BoxGap(width: 0, height: 9 * DesignVariables.heightConversion),
      ])
    );
  }
}