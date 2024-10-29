import 'package:flutter/material.dart';

class DesignVariables {
  static Color primaryRed = Color.fromARGB(255, 255, 92, 92);
  static Color greyLines = Color.fromARGB(255, 217, 217, 217);
  static Color offWhite = Color.fromARGB(255, 251, 251, 251);
  static Color gold = Color.fromARGB(255, 245, 184, 46);

  static late double widthConversion;
  static late double heightConversion;

  static void setConversions(context) {
    widthConversion = 1 / 430 * MediaQuery.of(context).size.width;
    heightConversion = 1 / 932 * MediaQuery.of(context).size.height;
  }
}
