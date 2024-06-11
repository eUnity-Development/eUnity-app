import 'package:eunity/classes/AuthHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';
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
    setState(() {
      AuthHelper.loggedIn = value;
      AuthHelper.prefs!.setBool('loggedIn', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    DesignVariables.setConversions(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthHelper.loggedIn ? const CoreTemplate() : const LoginSignup(),
    );
  }
}
