import 'package:flutter/material.dart';

class ScreenFour extends StatefulWidget {
  const ScreenFour({super.key});

  @override
  State<ScreenFour> createState() => _CreatePostState();
}

class _CreatePostState extends State<ScreenFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(child: Text("Screen Four")),
    );
  }
}
