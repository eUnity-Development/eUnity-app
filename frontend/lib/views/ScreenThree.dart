import 'package:flutter/material.dart';
import 'package:frontend/classes/ConnectionTester.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _CreatePostState();
}

class _CreatePostState extends State<ScreenThree> {
  bool init = true;
  String? testData;

  Future load() async {
    var testComm = await ConnectionTester.getTest();
    print(testComm);
    if (mounted) {
      setState(() {
        init = false;
      });
    }
  }

  void firstload() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    if (init) {
      firstload();
      init = false;
    }
    print(testData);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(child: Text("Screen Three")),
    );
  }
}
