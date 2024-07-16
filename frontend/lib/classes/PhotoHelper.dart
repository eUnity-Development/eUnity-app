import 'dart:io';

import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/FeedbackHelper.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class PhotoHelper {
  static Future<void> handleNewImage(
      File imagePath,
      List imageArray,
      int selectedImageGrid,
      BuildContext context,
      Function updateState,
      bool isReport) async {
    if (imageArray.length >= selectedImageGrid + 1) {
      if (isReport) {
        await FeedbackHelper.deleteReportImage(imageArray[selectedImageGrid]);
        await FeedbackHelper.uploadNewReportImage(imagePath);
      } else {
        await UserInfoHelper.deleteImage(imageArray[selectedImageGrid]);
        await UserInfoHelper.uploadNewImage(imagePath);
      }
    } else {
      if (isReport) {
        await FeedbackHelper.uploadNewReportImage(imagePath);
      } else {
        await UserInfoHelper.uploadNewImage(imagePath);
      }
    }
    updateState();
    Navigator.pop(context);
  }

  static Future<void> deleteImage(List imageArray, int selectedImageGrid,
      BuildContext context, Function updateState, bool isReport) async {
    if (imageArray.length >= selectedImageGrid + 1) {
      if (isReport) {
        await FeedbackHelper.deleteReportImage(imageArray[selectedImageGrid]);
      } else {
        await UserInfoHelper.deleteImage(imageArray[selectedImageGrid]);
      }
    } else {
      print("No image to delete!");
    }
    updateState();
    Navigator.pop(context);
  }

  static Future<void> openCamera(List imageArray, int selectedImageGrid,
      BuildContext context, Function updateState, bool isReport) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image == null) return;
    await handleNewImage(File(image.path), imageArray, selectedImageGrid,
        context, updateState, isReport);
  }

  static Future<void> openGallery(List imageArray, int selectedImageGrid,
      BuildContext context, Function updateState, bool isReport) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image == null) return;
    await handleNewImage(File(image.path), imageArray, selectedImageGrid,
        context, updateState, isReport);
  }

  static void openCameraDialog(List imageArray, int selectedImageGrid,
      BuildContext context, Function updateState, bool isReport) {
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
                    await openCamera(imageArray, selectedImageGrid, context,
                        updateState, isReport);
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
                    await openGallery(imageArray, selectedImageGrid, context,
                        updateState, isReport);
                  },
                ),
                SimpleDialogOption(
                  child: Text("Test Delete"),
                  onPressed: () async {
                    await deleteImage(imageArray, selectedImageGrid, context,
                        updateState, isReport);
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
}
