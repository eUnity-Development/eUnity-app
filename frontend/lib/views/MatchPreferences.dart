import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:flutter/material.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionButton.dart';
import 'package:eunity/widgets/MatchPreferencesWidgets/MatchPreferencesRangeSlider.dart';
import 'package:eunity/widgets/MatchPreferencesWidgets/MatchPreferencesSlider.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';

class MatchPreferences extends StatefulWidget {
  const MatchPreferences({super.key});

  @override
  State<MatchPreferences> createState() => _MatchPreferencesState();
}

class _MatchPreferencesState extends State<MatchPreferences> {
  Future<void> updateData() async {
    await UserInfoHelper.getUserInfo();
    setState(() {});
  }

  Future<void> patchData() async {
    await UserInfoHelper.patchUserInfo();
  }

  @override
  void initState() {
    updateData();
    super.initState();
  }

  @override
  void dispose() {
    patchData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle =
        TextStyle(fontWeight: FontWeight.w700, fontSize: 20);

    const TextStyle subStyle =
        TextStyle(fontWeight: FontWeight.w400, fontSize: 14);

    const SizedBox spacerBox = SizedBox(
      height: 8,
    );

    const SizedBox largeSpacer = SizedBox(
      height: 16,
    );

    return Scaffold(
        appBar: PushedScreenTopBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Match Preferences",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
                Text(
                  "There are many different kinds of people out there. Please, tell us, who are you interested in meeting?",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                largeSpacer,
                Text(
                  "Gender",
                  style: headerStyle,
                ),
                spacerBox,
                Text(
                  "Select the gender(s) of the people you are interested in meeting",
                  style: subStyle,
                ),
                spacerBox,
                SelectionButton(
                    cacheKey: "genders",
                    cacheObject: 'match_preferences',
                    assetPath: "None",
                    options: [
                      "Men",
                      "Women",
                    ],
                    multiSelect: true,
                    allowNull: false,
                    question: "Select Preferred Gender(s)"),
                largeSpacer,
                Text(
                  "Relationship Type",
                  style: headerStyle,
                ),
                spacerBox,
                Text(
                  "Select your preferred type(s) of relationship",
                  style: subStyle,
                ),
                spacerBox,
                SelectionButton(
                    cacheKey: "relationship_types",
                    cacheObject: 'match_preferences',
                    options: [
                      "Long Term Relationships",
                      "Short Term Relationships"
                    ],
                    multiSelect: true,
                    allowNull: false,
                    question: "Preferred Relationship",
                    assetPath: "assets/MiscIcons/icon-outline-star.svg"),
                largeSpacer,
                Text(
                  "Age Range",
                  style: headerStyle,
                ),
                spacerBox,
                Text(
                  "Select the range of ages you would like to match with",
                  style: subStyle,
                ),
                spacerBox,
                MatchPreferencesRangeSlider(
                    initialMinimum: UserInfoHelper
                        .userInfoCache['match_preferences']['minimum_age']
                        .toDouble(),
                    initialMaximum: UserInfoHelper
                        .userInfoCache['match_preferences']['maximum_age']
                        .toDouble()),
                largeSpacer,
                Text(
                  "Maximum Distance",
                  style: headerStyle,
                ),
                spacerBox,
                Text(
                  "Select the maximum distance you would like your matches to be away from you",
                  style: subStyle,
                ),
                MatchPreferencesSlider(
                    initialValue: UserInfoHelper
                        .userInfoCache['match_preferences']['maximum_distance']
                        .toDouble()),
              ],
            ),
          ),
        ));
  }
}
