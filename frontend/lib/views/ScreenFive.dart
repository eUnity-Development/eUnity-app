import 'package:flutter/material.dart';

class ScreenFive extends StatefulWidget {
  const ScreenFive({super.key});

  @override
  State<ScreenFive> createState() => _CreatePostState();
}

class _CreatePostState extends State<ScreenFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(child: Text("Screen Five")),
    );
  }
}
