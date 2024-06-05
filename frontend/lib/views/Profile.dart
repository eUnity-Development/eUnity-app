import 'dart:io';

import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/ProfileWidgets/EditImageSquare.dart';
import 'package:eunity/widgets/ProfileWidgets/NewImageSquare.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/FeedbackScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List imageArray = [];
  int selectedImageGrid = 0;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future<void> updateData() async {
    print("PRINTOUT");
    var response = await UserInfoHelper.getUserInfo();
    setState(() {
      if (response.data.containsKey('media_files')) {
        imageArray = response.data['media_files'];
      } else {
        imageArray = [];
      }
    });
    print('THE IMAGE ARRAY');
    print(imageArray);
  }

  void testFeedback() async {
    print("clicked feedback");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleNewImage(File imagePath) async {
      if (imageArray.length >= selectedImageGrid + 1) {
      } else {
        UserInfoHelper.uploadNewImage(imagePath);
      }
      setState(() {
        updateData();
      });
      Navigator.pop(context);
    }

    Future<void> openCamera() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (image == null) return;
      await handleNewImage(File(image.path));
    }

    void openCameraDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) {
            return Theme(
              data: Theme.of(context)
                  .copyWith(dialogBackgroundColor: DesignVariables.offWhite),
              child: SimpleDialog(
                title: Text("Image Source"),
                children: [
                  SimpleDialogOption(
                    child: Row(children: [
                      SvgPicture.asset(
                        "assets/MiscIcons/icon-camera.svg",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Open Camera")
                    ]),
                    onPressed: () async {
                      await openCamera();
                    },
                  ),
                  SimpleDialogOption(
                    child: Row(children: [
                      SvgPicture.asset(
                        "assets/MiscIcons/icon-photo.svg",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("From Gallery")
                    ]),
                    onPressed: () {
                      print("clicked stuff");
                    },
                  ),
                  SimpleDialogOption(
                    child: Row(children: [
                      SvgPicture.asset(
                        "assets/MiscIcons/icon-x.svg",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Close")
                    ]),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }

    Widget gridOption(int index) {
      if (imageArray.length < index + 1) {
        return NewImageSquare();
      } else {
        return EditImageSquare(imageURL: imageArray[index]);
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 1, color: DesignVariables.greyLines),
                      color: DesignVariables.primaryRed),
                  height: 51,
                  width: 207,
                  child: Center(
                    child: Text(
                      "Test Feedback Button",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              onTap: testFeedback,
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: gridOption(0),
              onTap: () {
                setState(() {
                  selectedImageGrid = 0;
                  openCameraDialog(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
