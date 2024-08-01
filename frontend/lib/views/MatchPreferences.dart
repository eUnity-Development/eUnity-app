import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/views/UserPrefs.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:eunity/widgets/NameDOBGender/birthday_classes.dart';
import 'package:flutter/material.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionButton.dart';
import 'package:eunity/widgets/MatchPreferencesWidgets/MatchPreferencesRangeSlider.dart';
import 'package:eunity/widgets/MatchPreferencesWidgets/MatchPreferencesSlider.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';

class MatchPreferences extends StatefulWidget {
  final bool inSetUp;
  const MatchPreferences({super.key, required this.inSetUp});

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

    Future<void> onNext() async {
      if (UserInfoHelper.userInfoCache['match_preferences']['genders'].length >
              0 &&
          UserInfoHelper
                  .userInfoCache['match_preferences']['relationship_types']
                  .length >
              0) {
        UserInfoHelper.userInfoCache['is_profile_set_up'] = true;
        var response = await UserInfoHelper.patchUserInfo();
        if (response.statusCode == 200) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => UserPrefs()),
            (Route<dynamic> route) => false,
          );
        }
      }
    }

    return Scaffold(
        appBar: PushedScreenTopBar(),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Match Preferences",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    Text(
                      "There are many different kinds of people out there. Please, tell us, who are you interested in meeting?",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
                            .userInfoCache['match_preferences']
                                ['maximum_distance']
                            .toDouble()),
                  ],
                ),
              ),
            ),
            (widget.inSetUp) ? const Spacer() : const SizedBox(),
            (widget.inSetUp)
                ? LoginSignupButton(
                    color: DesignVariables.primaryRed,
                    onTap: onNext,
                    borderColor: Colors.transparent,
                    height: 52 * DesignVariables.heightConversion,
                    width: 334.67 * DesignVariables.widthConversion,
                    buttonContent: LoginSignupButtonContent(
                      svgOffset: 18 * DesignVariables.widthConversion,
                      svgPath: 'assets/icons/arrow-long-left.svg',
                      svgDimensions: 36,
                      text: 'Next',
                      fontSize: 22,
                      fontColor: Colors.white,
                      isRight: true,
                      fontWeight: FontWeight.w700,
                    ))
                : SizedBox(),
            (widget.inSetUp) ? const BoxGap(width: 0, height: 36) : SizedBox(),
          ],
        ));
  }
}
