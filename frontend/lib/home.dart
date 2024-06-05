import 'package:eunity/views/LoginSignup.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DesignVariables.setConversions(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginSignup(),
    );
  }
}
