import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
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

    return (Scaffold(
        appBar: PushedScreenTopBar(hasSkip: true, onSkip: onSkip),
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.0 * DesignVariables.widthConversion),
              child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      // About header
                      Text(
                        "About",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      BoxGap(width: 0, height: 7),

                      // About description
                      Text(
                        "Matches will want to know more about you!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ]
                  )
                )
              )
            );
  }
}
