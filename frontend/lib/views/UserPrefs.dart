import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/home.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:eunity/widgets/TopBars/NoLogoTopBar.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:eunity/widgets/UserPrefs/user_prefs_button.dart';
import 'package:eunity/widgets/UserPrefs/user_prefs_list.dart';
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
      print('${key} ${UserInfoHelper.userInfoCache[key]}');
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

  void onNext() {
    onSkip();
  }

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
          isLongList: prefs['longList'],
          updateBtn: checkIfEntered);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    dynamic appBar = widget.inSetUp
        ? PushedScreenTopBar(hasSkip: true, onSkip: onSkip)
        : const NoLogoTopBar(title: "My Info");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 18.0 * DesignVariables.widthConversion),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // About header
              const Text(
                "About",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // const BoxGap(width: 0, height: 4),

              // About description
              widget.inSetUp ? const Text(
                "Matches will want to know more about you!",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ) : const SizedBox(),

              const BoxGap(width: 0, height: 10),
              Column(children: [
                ...createAboutButtons(context, UserPrefsList.aboutList)
              ]),
              Divider(color: DesignVariables.greyLines),
              BoxGap(width: 0, height: 5 * DesignVariables.heightConversion),

              // Lifestyle header
              const Text(
                "Lifestyle",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // const BoxGap(width: 0, height: 4),

              // Relationship description
              widget.inSetUp ? const Text(
                "Let your matches in on your lifestyle, habits, and preferences.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ) : const SizedBox(),
              const BoxGap(width: 0, height: 10),
              Column(children: [
                ...createAboutButtons(context, UserPrefsList.lifestyleList)
              ]),

              widget.inSetUp
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Divider(color: DesignVariables.greyLines),
                          BoxGap(
                              width: 0,
                              height: 5 * DesignVariables.heightConversion),

                          // Relationship header
                          const Text(
                            "Relationship",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const BoxGap(width: 0, height: 10),
                          Column(children: [
                            ...createAboutButtons(
                                context, UserPrefsList.relationshipList)
                          ]),
                        ]),

              const BoxGap(width: 0, height: 50),

              widget.inSetUp ?
              LoginSignupButton(
                  color: isEntered
                      ? DesignVariables.primaryRed
                      : DesignVariables.greyLines,
                  onTap: onNext,
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
                  )) : const SizedBox(),
              const BoxGap(width: 0, height: 36)
            ])),
      ),
    );
  }
}
