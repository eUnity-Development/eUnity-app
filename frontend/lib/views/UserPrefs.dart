import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/home.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
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
  bool isEntered = false;

  @override
  void initState() {
    super.initState();
    checkIfEntered();
  }

  void onSkip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
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
    if (isEntered) {
      onSkip();
    }
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
          multiSelect: prefs['multiSelect'],
          isLongList: prefs['longList'],
          updateBtn: checkIfEntered);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PushedScreenTopBar(hasSkip: true, onSkip: onSkip),
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
              Column(children: [
                ...createAboutButtons(context, UserPrefsList.lifestyleList)
              ]),

              const BoxGap(width: 0, height: 50),
        
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
                  )),
              const BoxGap(width: 0, height: 36)
            ])),
      ),
    );
  }
}
