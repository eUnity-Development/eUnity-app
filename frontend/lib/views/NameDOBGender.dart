import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';

class NameDOBGender extends StatefulWidget {
  const NameDOBGender({super.key});

  @override
  State<NameDOBGender> createState() => _NameDOBGender();
}

class _NameDOBGender extends State<NameDOBGender> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedScreenTopBar(hasArrow: false),


    );
  }
}