import 'package:flutter/material.dart';

class SplashScreenButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final Color borderColor;
  final Color textColor;
  final double height;
  final double width;

  const SplashScreenButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    required this.textColor,
    required this.borderColor,

    this.height = 52.0,
    this.width = 334.67,
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
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
