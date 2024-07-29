import 'package:eunity/classes/AuthHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/views/InitProfile.dart';
import 'package:eunity/views/LoginSignup.dart';
import 'package:flutter/material.dart';
import 'package:eunity/views/CoreTemplate.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    AuthHelper.init();
    AuthHelper.setLoggedIn = setLoggedIn;
  }

  void setLoggedIn(bool value) {
    AuthHelper.loggedIn = value;
    AuthHelper.prefs!.setBool('loggedIn', value);
    if (value) {
      UserInfoHelper.getUserInfo().then((onValue) {
        setState(() {});
      });
    }
    setState(() {});
  }

  Future<void> updateData() async {
    await UserInfoHelper.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    DesignVariables.setConversions(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: AuthHelper.loggedIn
            ? (UserInfoHelper.userInfoCache['is_profile_set_up'] == true)
                ? const CoreTemplate()
                : (UserInfoHelper.userInfoCache['is_profile_set_up'] == false)
                    ? InitProfile()
                    : Placeholder(
                        color: Colors.white,
                      )
            : const LoginSignup());
  }
}
