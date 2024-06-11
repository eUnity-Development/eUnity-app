import 'package:eunity/widgets/TopBars/NoLogoTopBar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/ProfileWidgets/EditImageSquare.dart';
import 'package:eunity/widgets/ProfileWidgets/NewImageSquare.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  @override
  Widget build(BuildContext context) {
    Future<void> handleNewImage(File imagePath) async {
      if (imageArray.length >= selectedImageGrid + 1) {
        await UserInfoHelper.deleteImage(imageArray[selectedImageGrid]);
        await UserInfoHelper.uploadNewImage(imagePath);
      } else {
        await UserInfoHelper.uploadNewImage(imagePath);
      }
      setState(() {
        updateData();
      });
      Navigator.pop(context);
    }

    Future<void> deleteImage() async {
      if (imageArray.length >= selectedImageGrid + 1) {
        await UserInfoHelper.deleteImage(imageArray[selectedImageGrid]);
      } else {
        print("No image to delete!");
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

    Future<void> openGallery() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
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
                    onPressed: () async {
                      await openGallery();
                    },
                  ),
                  SimpleDialogOption(
                    child: Text("Test Delete"),
                    onPressed: () async {
                      await deleteImage();
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
      Widget gridCore() {
        return GestureDetector(
          child: ((imageArray.length < index + 1)
              ? NewImageSquare()
              : EditImageSquare(
                  imageURL:
                      UserInfoHelper.getPublicImageURL(imageArray[index]))),
          onTap: () {
            setState(() {
              selectedImageGrid = index;
              openCameraDialog(context);
            });
          },
        );
      }

      return LongPressDraggable(
        child: (draggingImageGrid == index)
            ? SizedBox(
                height: 140 * DesignVariables.heightConversion,
                width: 140 * DesignVariables.widthConversion,
              )
            : gridCore(),
        feedback: gridCore(),
        onDragStarted: () {
          setState(() {
            draggingImageGrid = index;
          });
        },
        onDraggableCanceled: (velocity, offset) {
          print(offset.dx);
          print(offset.dy);
          setState(() {
            draggingImageGrid = -1;
          });
        },
      );
    }

    Widget imageGrids() {
      return Column(
        children: [
          Row(
            children: [gridOption(0), gridOption(1), gridOption(2)],
          ),
          Row(
            children: [gridOption(3), gridOption(4), gridOption(5)],
          ),
          Row(
            children: [gridOption(6), gridOption(7), gridOption(8)],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: NoLogoTopBar(title: "Edit Profile"),
      body: Column(children: [
        Text(
          "Photos",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        imageGrids(),
      ]),
    );
  }
}
