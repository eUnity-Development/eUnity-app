import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewImageSquare extends StatelessWidget {
  const NewImageSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140 * DesignVariables.heightConversion,
      width: 140 * DesignVariables.widthConversion,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: DottedBorder(
            radius: Radius.circular(25 * DesignVariables.heightConversion),
            strokeWidth: 1,
            color: Colors.black,
            borderType: BorderType.RRect,
            child: Container(
              height: 119 * DesignVariables.heightConversion,
              width: 116 * DesignVariables.widthConversion,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.circular(
                      21 * DesignVariables.heightConversion)),
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 41 * DesignVariables.widthConversion,
            height: 41 * DesignVariables.heightConversion,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: SvgPicture.asset(
                'assets/MiscIcons/icon-plus.svg',
                height: 24 * DesignVariables.heightConversion,
                width: 24 * DesignVariables.widthConversion,
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
