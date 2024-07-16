import 'package:eunity/classes/PhotoHelper.dart';
import 'package:eunity/views/InitBio.dart';
import 'package:eunity/widgets/ImageWidgets/ImageGrid.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button_content.dart';
import 'package:eunity/widgets/NameDOBGender/birthday_classes.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPhotos extends StatefulWidget {
  const AddPhotos({super.key});

  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  List imageArray = [];
  int selectedImageGrid = 0;
  int draggingImageGrid = -1;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future<void> updateData() async {
    var response = await UserInfoHelper.getUserInfo();
    setState(() {
      if (response.data.containsKey('media_files')) {
        imageArray = response.data['media_files'];
      } else {
        imageArray = [];
      }
    });
  }

  Future<void> patchData() async {
    await UserInfoHelper.patchUserInfo();
  }

  void updateState() async {
    setState(() {
      updateData();
    });
  }

  Future<void> onNext() async {
    if (imageArray.length > 0) {
      var response = await UserInfoHelper.patchUserInfo();
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InitBio()),
        );
      }
    }
  }

  void onItemClick(int index) {
    setState(() {
      selectedImageGrid = index;
      PhotoHelper.openCameraDialog(
          imageArray, selectedImageGrid, context, updateState, false);
    });
  }

  Future<void> onReorder(int fromIndex, int index) async {
    if (fromIndex < imageArray.length && index < imageArray.length) {
      final fromItem = imageArray.removeAt(fromIndex);
      imageArray.insert(index, fromItem);
    }
    await patchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = const TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700);

    TextStyle footerStyle = const TextStyle(
        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400);

    return Scaffold(
      appBar: PushedScreenTopBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Select Photos",
            style: headerStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Select photos that will display on your profile and when others view you on the matching screen. Look your best!",
            style: footerStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: ImageGrid(
                imageArray: imageArray,
                onItemClick: onItemClick,
                onReorder: onReorder),
            height: 400,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SvgPicture.asset("assets/MiscIcons/icon-i-circle.svg"),
              Text(
                "Hold & drag to re-arrange",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(128, 0, 0, 0)),
              )
            ],
          ),
          const Spacer(),
          LoginSignupButton(
              color: (imageArray.length > 0)
                  ? DesignVariables.primaryRed
                  : DesignVariables.greyLines,
              onTap: onNext,
              borderColor: Colors.transparent,
              height: 52 * DesignVariables.heightConversion,
              width: 334.67 * DesignVariables.widthConversion,
              buttonContent: LoginSignupButtonContent(
                svgOffset: 18 * DesignVariables.widthConversion,
                svgPath: 'assets/icons/arrow-long-left.svg',
                svgDimensions: 36,
                text: 'Next',
                fontSize: 22,
                fontColor: Colors.white,
                isRight: true,
                fontWeight: FontWeight.w700,
              )),
          const BoxGap(width: 0, height: 36),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
