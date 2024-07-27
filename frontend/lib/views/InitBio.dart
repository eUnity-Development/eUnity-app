import 'package:eunity/views/MatchPreferences.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:eunity/widgets/NameDOBGender/birthday_classes.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';

class InitBio extends StatefulWidget {
  const InitBio({super.key});

  @override
  State<InitBio> createState() => _InitBioState();
}

class _InitBioState extends State<InitBio> {
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future<void> updateData() async {
    await UserInfoHelper.getUserInfo();
    setState(() {
      if (UserInfoHelper.userInfoCache['bio'] != null &&
          UserInfoHelper.userInfoCache['bio'] != '') {
        bioController.text = UserInfoHelper.userInfoCache['bio'];
      }
    });
  }

  Future<void> onNext() async {
    if (bioController.text != '') {
      UserInfoHelper.updateCacheVariable('bio', '', bioController.text);
      var response = await UserInfoHelper.patchUserInfo();
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchPreferences(
                    inSetUp: true,
                  )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = const TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700);

    const TextStyle hintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Color.fromARGB(128, 0, 0, 0));

    BoxDecoration textFieldDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    return Scaffold(
      appBar: PushedScreenTopBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Bio",
            style: headerStyle,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: textFieldDecorator,
            height: 120,
            width: double.infinity,
            child: TextField(
              controller: bioController,
              maxLines: null,
              maxLength: 500,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Enter Bio Here",
                hintStyle: hintStyle,
                hintMaxLines: 100,
                border: InputBorder.none,
              ),
            ),
          ),
          const Spacer(),
          LoginSignupButton(
              color: (bioController.text != '')
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
                text: 'Next',
                fontSize: 22,
                fontColor: Colors.white,
                isRight: true,
                fontWeight: FontWeight.w700,
              )),
          const BoxGap(width: 0, height: 36),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }
}
