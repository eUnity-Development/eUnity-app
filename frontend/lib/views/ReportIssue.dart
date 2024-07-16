import 'package:dio/dio.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/FeedbackHelper.dart';
import 'package:eunity/classes/PhotoHelper.dart';
import 'package:eunity/views/ConfirmationScreen.dart';
import 'package:eunity/widgets/ImageWidgets/PhotoGridItem.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  TextEditingController reportController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late bool hasOpenReport;
  List imageArray = [];

  @override
  void initState() {
    loadReportData();
    super.initState();
  }

  Future<void> loadReportData() async {
    var response = await FeedbackHelper.getIssueReport();
    if (response.statusCode == 200) {
      hasOpenReport = true;
      reportController.text = response.data['description'];
      emailController.text = response.data['email'];
      imageArray = response.data['media_files'];
      setState(() {});
    } else {
      hasOpenReport = false;
      imageArray = [];
    }
  }

  Future<void> patchData(bool forceUpdate) async {
    if (hasOpenReport) {
      Map<dynamic, dynamic> newData = {
        'description': reportController.text,
        'email': emailController.text,
        'media_files': imageArray,
      };
      await FeedbackHelper.updateIssueReport(newData);
    } else {
      if ((reportController.text != "" ||
              emailController.text != "" ||
              imageArray != []) ||
          forceUpdate) {
        await FeedbackHelper.AddIssueReport(
            reportController.text, emailController.text, imageArray);
        Map<dynamic, dynamic> newData = {
          'description': reportController.text,
          'email': emailController.text,
        };
        await FeedbackHelper.updateIssueReport(newData);
        setState(() {
          hasOpenReport = true;
        });
      }
    }
  }

  Future<void> onSubmit() async {
    Response response;
    bool reportSwitch = hasOpenReport;

    if (hasOpenReport) {
      Map<dynamic, dynamic> newData = {
        'description': reportController.text,
        'email': emailController.text,
      };
      response = await FeedbackHelper.updateIssueReport(newData);
    } else {
      response = await FeedbackHelper.AddIssueReport(
          reportController.text, emailController.text, imageArray);
    }

    if (response.statusCode == 200) {
      reportSwitch = true;
      Response submitResponse = await FeedbackHelper.submitIssueReport();
      if (submitResponse.statusCode == 200) {
        reportSwitch = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Scaffold(
                body: ConfirmationScreen(
                  confirmationTitle: "Thank you for submitting your report!",
                  confirmationBody:
                      "At eUnity, our user's experiences are always important to us. Thank you for sharing yours with us. We will do our best to ensure it is heard and your concerns are addressed as quickly as possible.",
                ),
              );
            },
          ),
        );
      } else {
        if (reportController.text == "") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please Describe the Issue!'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        setState(() {
          hasOpenReport = reportSwitch;
        });
      }
    } else {
      setState(() {
        hasOpenReport = reportSwitch;
      });
    }
  }

  void updateState() async {
    await loadReportData();
    setState(() {});
  }

  Future<void> onItemClick(int index) async {
    await patchData(true);
    setState(() {
      PhotoHelper.openCameraDialog(
          imageArray, index, context, updateState, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24);

    const footerStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14);

    const altFooterStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);

    const TextStyle hintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Color.fromARGB(128, 0, 0, 0));

    const TextStyle emailHintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color.fromARGB(128, 0, 0, 0));

    BoxDecoration textFieldDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    Widget ScreenShotRow = Row(
      children: [
        PhotoGridItem(
            imageArray: imageArray,
            index: 0,
            onClick: onItemClick,
            isReport: true),
        PhotoGridItem(
            imageArray: imageArray,
            index: 1,
            onClick: onItemClick,
            isReport: true),
        PhotoGridItem(
            imageArray: imageArray,
            index: 2,
            onClick: onItemClick,
            isReport: true)
      ],
    );

    SizedBox largeSpacer = const SizedBox(
      height: 20,
    );

    SizedBox smallSpacer = const SizedBox(
      height: 10,
    );

    return Scaffold(
      appBar: PushedScreenTopBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Report Issue",
                  style: headerStyle,
                ),
                largeSpacer,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    "Here at eUnity, we strive to achieve an intuitive and smooth user experience. If you are experiencing issues with the eUnity app, please let us know here!",
                    style: altFooterStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                largeSpacer,
                Text(
                  "Describe The Issue",
                  style: headerStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: textFieldDecorator,
                    height: 120,
                    width: double.infinity,
                    child: TextField(
                      controller: reportController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText:
                            "Please describe the issue with as much detail as possible.",
                        hintStyle: hintStyle,
                        hintMaxLines: 100,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                largeSpacer,
                Text(
                  "Screenshots",
                  style: headerStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "If applicable, please send screenshots of your issue so our team can better pinpoint the problem and develop a solution.",
                    style: footerStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                ScreenShotRow,
                largeSpacer,
                Text(
                  "Contact Email",
                  style: headerStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Please provide a contact email our team can reach out to in case we have further questions.",
                    style: footerStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                smallSpacer,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: textFieldDecorator,
                    height: 50,
                    width: double.infinity,
                    child: TextField(
                      controller: emailController,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter email here.",
                        hintStyle: emailHintStyle,
                        hintMaxLines: 1,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                largeSpacer,
                Padding(
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
                          "Submit Report",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                      ),
                    ),
                    onTap: onSubmit,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    patchData(false);
    reportController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
