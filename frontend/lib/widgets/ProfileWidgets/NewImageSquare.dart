import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewImageSquare extends StatelessWidget {
  const NewImageSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: DottedBorder(
            radius: Radius.circular(25),
            strokeWidth: 1,
            color: Colors.black,
            borderType: BorderType.RRect,
            child: Container(
              height: 119,
              width: 116,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.circular(21)),
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 41,
            height: 41,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: SvgPicture.asset(
                'assets/MiscIcons/icon-plus.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
          right: 0,
          bottom: 0,
        )
      ]),
    );
  }
}
