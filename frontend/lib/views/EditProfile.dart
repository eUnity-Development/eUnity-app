import 'package:eunity/classes/PhotoHelper.dart';
import 'package:eunity/widgets/ImageWidgets/ImageGrid.dart';
import 'package:eunity/widgets/TopBars/NoLogoTopBar.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/classes/DesignVariables.dart';

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
  late String originalBio;

  @override
  void initState() {
    super.initState();
    updateData();
    bioController.text = UserInfoHelper.userInfoCache['bio'];
    originalBio = UserInfoHelper.userInfoCache['bio'];
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

    const TextStyle hintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Color.fromARGB(128, 0, 0, 0));

    BoxDecoration textFieldDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    return Scaffold(
      appBar: NoLogoTopBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Photos",
              style: headerStyle,
            ),
            Container(
              child: ImageGrid(
                  imageArray: imageArray,
                  onItemClick: onItemClick,
                  onReorder: onReorder),
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
                onChanged: (value) {
                  UserInfoHelper.userInfoCache['bio'] = value;
                },
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
      ),
    );
  }

  @override
  void dispose() {
    if (bioController.text != '') {
      patchData();
    } else {
      UserInfoHelper.userInfoCache['bio'] = originalBio;
    }
    bioController.dispose();
    super.dispose();
  }
}
