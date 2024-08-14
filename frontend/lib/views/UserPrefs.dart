import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/home.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:eunity/widgets/TopBars/NoLogoTopBar.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:eunity/widgets/UserPrefs/user_prefs_list.dart';
import 'package:eunity/widgets/UserPrefs/user_prefs_section.dart';
import 'package:flutter/material.dart';
import '../widgets/NameDOBGender/birthday_classes.dart';

class UserPrefs extends StatefulWidget {
  final bool inSetUp;
  const UserPrefs({super.key, required this.inSetUp});

  @override
  State<StatefulWidget> createState() {
    return UserPrefsState();
  }
}

class UserPrefsState extends State<UserPrefs> {
  bool isEntered = false;

  @override
  void initState() {
    super.initState();
    getData().then(
      (value) {
        checkIfEntered();
      },
    );
  }

  @override
  void dispose() {
    updateData();
    super.dispose();
  }

  Future<void> getData() async {
    await UserInfoHelper.getUserInfo();
  }

  Future<void> updateData() async {
    await UserInfoHelper.patchUserInfo();
  }

  void onSkip() async {
    UserInfoHelper.userInfoCache['is_profile_set_up'] = true;
    var response = await UserInfoHelper.patchUserInfo();
    if (response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void checkIfEntered() {
    bool allFilled = true;
    List<Map> buttonList =
        UserPrefsList.aboutList + UserPrefsList.lifestyleList;
    for (int i = 0; i < buttonList.length; i++) {
      String key = buttonList[i]['cacheKey'];
      // print('${key} ${UserInfoHelper.userInfoCache[key]}');
      if (key != 'city' && key != 'job') {
        if (UserInfoHelper.userInfoCache[key] == null ||
            UserInfoHelper.userInfoCache[key] == 'Add' ||
            UserInfoHelper.userInfoCache[key].length == 0) {
          allFilled = false;
        }
      }
    }
    setState(() {
      isEntered = allFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic appBar = widget.inSetUp
        ? const PushedScreenTopBar()
        : const NoLogoTopBar(title: "Edit My Info");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 18.0 * DesignVariables.widthConversion),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // About Section
              UserPrefsSection(
                  hasDivider: true,
                  inSetUp: widget.inSetUp,
                  header: "About",
                  description: "Matches will want to know more about you!",
                  prefList: UserPrefsList.aboutList),

              // Lifestyle Section
              UserPrefsSection(
                  hasDivider: !widget.inSetUp,
                  inSetUp: widget.inSetUp,
                  header: "Lifestyle",
                  description:
                      "Let your matches in on your lifestyle, habits, and preferences.",
                  prefList: UserPrefsList.lifestyleList),
              
              widget.inSetUp
                  // If in setup, display the finish button
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BoxGap(width: 0, height: 35),
                        LoginSignupButton(
                            color: DesignVariables.primaryRed,
                            onTap: onSkip,
                            borderColor: Colors.transparent,
                            height: 52 * DesignVariables.heightConversion,
                            width: 334.67 * DesignVariables.widthConversion,
                            buttonContent: LoginSignupButtonContent(
                              svgOffset: 18 * DesignVariables.widthConversion,
                              svgPath: 'assets/icons/arrow-long-left.svg',
                              svgDimensions: 36,
                              text: 'Finish',
                              fontSize: 22,
                              fontColor: Colors.white,
                              isRight: true,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    )
                    
                  // Otherwise, display the relationship section
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserPrefsSection(
                            hasDivider: false,
                            inSetUp: false,
                            header: "Relationship",
                            description: "",
                            prefList: UserPrefsList.relationshipList),
                      ],
                    ),
              const BoxGap(width: 0, height: 35)
            ])),
      ),
    );
  }
}
