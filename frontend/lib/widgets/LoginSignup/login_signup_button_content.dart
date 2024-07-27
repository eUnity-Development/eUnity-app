import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginSignupButtonContent extends StatelessWidget {
  final double svgOffset;
  final String svgPath;
  final double svgDimensions;
  final String text;
  final double fontSize;
  final Color fontColor;
  final bool? isRight;
  final FontWeight? fontWeight;

  const LoginSignupButtonContent({
    super.key,
    required this.svgOffset,
    required this.svgPath,
    required this.svgDimensions,
    required this.text,
    required this.fontSize,
    required this.fontColor,
    this.isRight,
    this.fontWeight
  });

  @override
  Widget build(BuildContext context) {

    bool isSVGRight = isRight ?? false;
    FontWeight finalFontWeight = fontWeight ?? FontWeight.w700;

    return Row(
      children: [
        isSVGRight ? 
        const SizedBox() :
        SizedBox(
            width: svgOffset
        ),
      isSVGRight ?
        SizedBox(
          width: svgOffset + svgDimensions,
        ) :
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
                fontWeight: finalFontWeight,
              ),
            ),
          )
        ),

        isSVGRight ?
          SvgPicture.asset(
            svgPath,
            width: svgDimensions,
            height: svgDimensions,
          ) :
          SizedBox(
            width: svgOffset + svgDimensions,
          ),  

        isSVGRight ? 
          SizedBox(
            width: svgOffset,
          ) :
          const SizedBox()
      ],
    ); 
  }
}





