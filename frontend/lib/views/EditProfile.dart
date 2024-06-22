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
  TextEditingController bioController = TextEditingController();

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

    Widget gridItem(int index) {
      return GestureDetector(
        child: (imageArray.length <= index)
            ? NewImageSquare()
            : EditImageSquare(
                imageURL: UserInfoHelper.getPublicImageURL(imageArray[index])),
        onTap: () {
          setState(() {
            selectedImageGrid = index;
            openCameraDialog(context);
          });
        },
      );
    }

    Widget gridOption(int index) {
      if (index >= imageArray.length) {
        return gridItem(index);
      }
      return LongPressDraggable<int>(
        data: index,
        feedback: gridItem(index),
        childWhenDragging: Container(
          decoration: BoxDecoration(
              color: DesignVariables.greyLines,
              borderRadius:
                  BorderRadius.circular(21 * DesignVariables.heightConversion)),
        ),
        child: DragTarget<int>(
          builder: (BuildContext context, List<int?> candidateData,
              List<dynamic> rejectedData) {
            return gridItem(index);
          },
          onAccept: (int fromIndex) {
            setState(() {
              if (fromIndex < imageArray.length && index < imageArray.length) {
                final fromItem = imageArray.removeAt(fromIndex);
                imageArray.insert(index, fromItem);
              }
            });
          },
        ),
      );
    }

    List<int> items = List<int>.generate(9, (index) => index);

    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final int item = items.removeAt(oldIndex);
        items.insert(newIndex, item);
      });
    }

    Widget imageGrid() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          crossAxisSpacing: 10, // Horizontal spacing between grid items
          mainAxisSpacing: 10, // Vertical spacing between grid items
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 9, // Total number of items (3x3 grid)
        itemBuilder: (context, index) {
          return gridOption(index);
        },
      );
    }

    TextStyle headerStyle = const TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700);

    const TextStyle hintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Color.fromARGB(128, 0, 0, 0));

    BoxDecoration textFieldDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    return Scaffold(
      appBar: NoLogoTopBar(title: "Edit Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Photos",
            style: headerStyle,
          ),
          Container(
            child: imageGrid(),
            height: 400,
          ),
          Text(
            "Bio",
            style: headerStyle,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: textFieldDecorator,
            height: 120,
            width: double.infinity,
            child: TextField(
              controller: bioController,
              maxLines: null,
              maxLength: 500,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Enter Bio Here",
                hintStyle: hintStyle,
                hintMaxLines: 100,
                border: InputBorder.none,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }
}
