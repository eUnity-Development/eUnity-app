import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter/material.dart';

class DisplayPhoto extends StatelessWidget {
  final String imageURL;
  DisplayPhoto({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140 * DesignVariables.heightConversion,
      width: 140 * DesignVariables.widthConversion,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            child: Image.network(imageURL),
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
      ]),
    );
  }
}
