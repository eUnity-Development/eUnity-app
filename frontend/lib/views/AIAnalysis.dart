import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/ImageWidgets/DisplayImageGrid.dart';
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
                (isUpdate) ? "Update AI Analysis" : "Get AI Analysis",
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Container(
            height: 550,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Your Photos",
                    style: headerStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: DisplayImageGrid(
                      imageArray: imageArray,
                    ),
                    height: (400 / 3 * (((imageArray.length - 1) ~/ 3) + 1)),
                  ),
                  Text(
                    "AI Photo Analysis",
                    style: headerStyle,
                  ),
                  getTextBox(analysis['photo_analysis'].toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Bio",
                    style: headerStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text("AI Bio Analysis", style: headerStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  getTextBox(analysis['bio_analysis'].toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Overall Analysis",
                    style: headerStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  getTextBox(analysis['overall_analysis'].toString()),
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
