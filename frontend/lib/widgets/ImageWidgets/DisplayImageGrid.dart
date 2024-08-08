import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/ImageWidgets/DisplayPhoto.dart';
import 'package:flutter/material.dart';

class DisplayImageGrid extends StatelessWidget {
  final List imageArray;
  const DisplayImageGrid({super.key, required this.imageArray});

  @override
  Widget build(BuildContext context) {
    int axisCount = 3;
    if (imageArray.length == 1) {
      axisCount = 1;
    }
    if (imageArray.length == 2) {
      axisCount = 2;
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: axisCount, // Number of columns
          crossAxisSpacing: 10, // Horizontal spacing between grid items
          mainAxisSpacing: 10, // Vertical spacing between grid items
          mainAxisExtent: 119 * DesignVariables.heightConversion),
      physics: NeverScrollableScrollPhysics(),
      itemCount: imageArray.length, // Total number of items (3x3 grid)
      itemBuilder: (context, index) {
        return DisplayPhoto(
            imageURL: UserInfoHelper.getPublicImageURL(imageArray[index]));
      },
    );
  }
}
