import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/NameDOBGender/birthday_classes.dart';
import 'package:eunity/widgets/UserPrefs/user_prefs_button.dart';
import 'package:flutter/material.dart';

class UserPrefsSection extends StatefulWidget {
  final bool hasDivider;
  final bool inSetUp;
  final String header;
  final String description;
  final List<Map<String, dynamic>> prefList;

  const UserPrefsSection(
      {super.key,
      required this.hasDivider,
      required this.inSetUp,
      required this.header,
      required this.description,
      required this.prefList});

  @override
  State<StatefulWidget> createState() {
    return UserPrefsState();
  }
}

class UserPrefsState extends State<UserPrefsSection> {
  List<Widget> createAboutButtons(
      BuildContext context, List<Map<String, dynamic>> prefList) {
    return prefList.map((prefs) {
      return UserPrefsButton(
          name: prefs['name'],
          context: context,
          options: prefs['options'],
          question: prefs['question'],
          assetPath: prefs['assetPath'],
          cacheKey: prefs['cacheKey'],
          cacheObject: prefs['cacheObject'],
          multiSelect: prefs['multiSelect'],
          isLongList: prefs['longList']);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double gapHeight;
    widget.inSetUp ? gapHeight = 10 : gapHeight = 3;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Header
      Text(
        widget.header,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),

      // Description
      widget.inSetUp
          ? Text(
              widget.description,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
          : const SizedBox(),

      BoxGap(width: 0, height: gapHeight),

      // Buttons
      Column(
          children: [...createAboutButtons(context, widget.prefList)]),

      // Divider
      widget.hasDivider ? Column(
        children: [
          Divider(color: DesignVariables.greyLines),
          const BoxGap(width: 0, height: 3)
        ]) : const SizedBox()
    ]);
  }
}
