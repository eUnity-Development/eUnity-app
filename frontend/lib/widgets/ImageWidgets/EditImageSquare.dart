import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditImageSquare extends StatefulWidget {
  const EditImageSquare({super.key, required this.imageURL});
  final String imageURL;

  @override
  State<EditImageSquare> createState() => _EditImageSquareState();
}

class _EditImageSquareState extends State<EditImageSquare> {
  Image? userImage;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140 * DesignVariables.heightConversion,
      width: 140 * DesignVariables.widthConversion,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            child: Image.network(widget.imageURL),
            height: 119 * DesignVariables.heightConversion,
            width: 116 * DesignVariables.widthConversion,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(
                    21 * DesignVariables.heightConversion),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                )),
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
                'assets/MiscIcons/icon-pencil.svg',
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
