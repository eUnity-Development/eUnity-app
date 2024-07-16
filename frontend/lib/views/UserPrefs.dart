import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:eunity/widgets/UserPrefs/user_prefs_button.dart';
import 'package:eunity/widgets/UserPrefs/user_prefs_list.dart';
import 'package:flutter/material.dart';
import '../widgets/NameDOBGender/birthday_classes.dart';

class UserPrefs extends StatefulWidget {
  const UserPrefs({super.key});

  @override
  State<StatefulWidget> createState() {
    return UserPrefsState();
  }
}

class UserPrefsState extends State<UserPrefs> {
  @override
  Widget build(BuildContext context) {
    void onSkip() {
      print('Skip placeholder!');
    }

    List<Widget> createAboutButtons(BuildContext context, List<Map<String, dynamic>> prefList) {
      return prefList.map((prefs) {
        return UserPrefsButton(
          name: prefs['name'],
          context: context,
          options: prefs['options'],
          question: prefs['question'],
          assetPath: prefs['assetPath'],
          cacheKey: prefs['cacheKey'],
          multiSelect: prefs['multiSelect'],
        );
      }).toList();
    }

    return (Scaffold(
        appBar: PushedScreenTopBar(hasSkip: true, onSkip: onSkip),
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.0 * DesignVariables.widthConversion),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      // About header
                      const Text(
                        "About",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const BoxGap(width: 0, height: 7),

                      // About description
                      const Text(
                        "Matches will want to know more about you!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      
                      const BoxGap(width: 0, height: 7),
                      Column(children: [...createAboutButtons(context, UserPrefsList.aboutList)]),
                      BoxGap(width: 0, height: 6 * DesignVariables.heightConversion),
                      Divider(color: DesignVariables.greyLines),
                      BoxGap(width: 0, height: 15 * DesignVariables.heightConversion),

                      // Lifestyle header
                      const Text(
                        "Lifestyle",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const BoxGap(width: 0, height: 7),

                      // Lifestyle description
                      const Text(
                        "Let your matches in on your lifestyle, habits, and preferences.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const BoxGap(width: 0, height: 7),
                      Column(children: [...createAboutButtons(context, UserPrefsList.lifestyleList)])
                    ]
                  )
                )
              )
            );
  }
}
