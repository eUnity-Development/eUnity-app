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
      height: 140,
      width: 140,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            child: Image.network(widget.imageURL),
            height: 119,
            width: 116,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                )),
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
                'assets/MiscIcons/icon-pencil.svg',
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
