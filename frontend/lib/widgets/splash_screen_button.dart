import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenButton extends StatelessWidget {
  final String? text;
  final Color color;
  final VoidCallback onTap;
  final Color borderColor;
  final Color textColor;
  final double height;
  final double width;
  final SvgPicture? svgIcon;

  const SplashScreenButton({
    super.key,
    this.text,
    required this.color,
    required this.onTap,
    required this.textColor,
    required this.borderColor,
    required this.height,
    required this.width,
    this.svgIcon,
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
            child: text != null ? Text(
              text!,
              style: TextStyle(
                color: textColor,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ) : svgIcon,
          ),
        ),
      ),
    );
  }
}
