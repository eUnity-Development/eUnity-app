import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/ImageWidgets/DisplayImageGrid.dart';
import 'package:eunity/widgets/MessageWidgets/MessageBubble.dart';
import 'package:flutter/material.dart';

class AIAnalysis extends StatefulWidget {
  const AIAnalysis({super.key});

  @override
  State<AIAnalysis> createState() => _AIAnalysisState();
}

class _AIAnalysisState extends State<AIAnalysis> {
  bool analysisLoaded = false;
  bool init = false;
  List imageArray = UserInfoHelper.userInfoCache['media_files'];
  Map<dynamic, dynamic> analysis = {};

  @override
  void initState() {
    getAnalysis();
    super.initState();
  }

  Future<void> getAnalysis() async {
    await UserInfoHelper.getAIAnalysis().then((response) {
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            analysisLoaded = true;
            analysis = response.data;
            init = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            init = true;
          });
        }
      }
    });
  }

  Future<void> requestAnalysis() async {
    if (mounted) {
      setState(() {
        init = false;
      });
    }
    await UserInfoHelper.requestAIAnalysis().then(
      (response) async {
        await getAnalysis();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget getWingmanWidget(String content) {
      return Stack(
        children: [
          Positioned(
            left: 5,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(64, 0, 0, 0),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/images/happyrobot.png"),
                  radius: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42),
            child: MessageBubble(
              messageContent: content,
              sentByUser: false,
              isTopStack: false,
            ),
          ),
        ],
      );
    }

    TextStyle headerStyle = TextStyle(
        fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700);

    TextStyle mixedStyle = TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600);

    TextStyle footerStyle = TextStyle(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400);

    BoxDecoration analysisDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    Widget loading = Center(
      child: CircularProgressIndicator(
        color: DesignVariables.primaryRed,
      ),
    );

    Widget getAnalysisButton(bool isUpdate) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
                color: DesignVariables.primaryRed,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(64, 0, 0, 0),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0)
                ]),
            child: Center(
              child: Text(
                (isUpdate) ? "Update Wingman Analysis" : "Get Wingman Analysis",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              ),
            ),
          ),
          onTap: requestAnalysis,
        ),
      );
    }

    Widget getTextBox(String text) {
      return IntrinsicHeight(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: analysisDecorator,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    text,
                    style: footerStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
      );
    }

    Widget loadedColumn = Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Container(
            height: 550,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Your Photos",
                    style: mixedStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: DisplayImageGrid(
                        imageArray: imageArray,
                      ),
                      height: (400 / 3 * (((imageArray.length - 1) ~/ 3) + 1)),
                    ),
                  ),
                  getWingmanWidget(analysis['photo_analysis'].toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: DesignVariables.greyLines,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Bio",
                    style: mixedStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IntrinsicHeight(
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: analysisDecorator,
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                UserInfoHelper.userInfoCache['bio'],
                                style: footerStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  getWingmanWidget(analysis['bio_analysis'].toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: DesignVariables.greyLines,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Wingman's Overall Impressions",
                    style: mixedStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  getWingmanWidget(analysis['overall_analysis'].toString()),
                ],
              ),
            ),
          ),
          Spacer(),
          getAnalysisButton(true)
        ],
      ),
    );

    Widget unloadedColumn = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Text(
            "No Report Available",
            style: headerStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "For your first AI Analysis of your profile, please click the \"Get Analysis\" button!",
            style: footerStyle,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          getAnalysisButton(false)
        ],
      ),
    );

    return (init)
        ? (analysisLoaded)
            ? loadedColumn
            : unloadedColumn
        : loading;
  }
}
