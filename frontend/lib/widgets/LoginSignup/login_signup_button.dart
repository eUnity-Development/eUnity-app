import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {

  final Color color;
  final VoidCallback onTap;
  final Color borderColor;
  final double height;
  final double width;
  final Widget buttonContent;

  const LoginSignupButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.borderColor,
    required this.height,
    required this.width,
    required this.buttonContent,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: color,
            border: Border.all(color: borderColor),
          ),
          height: height,
          width: width,
          child: Center(
            // We can reuse widget for both svg and text
            child: buttonContent,
          ),
        ),
      ),
    );
  }
}
