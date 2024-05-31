import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenButtonContent extends StatelessWidget {
  final double svgOffset;
  final String svgPath;
  final double svgDimensions;
  final String text;
  final double fontSize;
  final Color fontColor;

  const SplashScreenButtonContent({
    super.key,
    required this.svgOffset,
    required this.svgPath,
    required this.svgDimensions,
    required this.text,
    required this.fontSize,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: svgOffset
        ),

        SvgPicture.asset(
          svgPath,
          width: svgDimensions,
          height: svgDimensions,
        ),

        Expanded(
          child:Center(
            child: Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ),

        SizedBox(
          width: svgOffset + svgDimensions,
        ),    
      ],
    ); 
  }
}





