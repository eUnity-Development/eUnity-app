import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/classes/ReportHelper.dart';
import 'package:eunity/views/ConfirmationScreen.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';

class ReportUser extends StatefulWidget {
  const ReportUser({super.key});

  @override
  State<ReportUser> createState() => _ReportUserState();
}

class _ReportUserState extends State<ReportUser> {
  TextEditingController reportController = TextEditingController();

  List reportReasons = [
    'Inappropriate profile (pictures and/or bio)',
    'Inappropriate chats',
    'This profile is advertising/self promotion',
    'Concerned for the safety of the user'
  ];
  List selectedReasons = [];

  Future<void> onSubmit() async {
    if (selectedReasons.length > 0) {
      var response = await ReportHelper.AddUserReport(
          "reportedUser", selectedReasons, reportController.text);
      print(response);
      if (response.statusCode == 200) {
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
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select some rule violations!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black);

    const TextStyle normalStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black);

    const TextStyle hintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Color.fromARGB(128, 0, 0, 0));

    BoxDecoration textFieldDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    const SizedBox largeSpacer = SizedBox(
      height: 20,
    );

    const SizedBox smallSpacer = SizedBox(
      height: 10,
    );

    BorderSide checkboxBorder = BorderSide(color: DesignVariables.greyLines);

    Border standardBorder = Border(
        left: checkboxBorder, right: checkboxBorder, bottom: checkboxBorder);

    Border topBorder = Border(
        top: checkboxBorder,
        left: checkboxBorder,
        right: checkboxBorder,
        bottom: checkboxBorder);

    Widget checkTile(int index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: CheckboxListTile(
            value: selectedReasons.contains(reportReasons[index]),
            onChanged: (bool? value) {
              setState(() {
                if (selectedReasons.contains(reportReasons[index])) {
                  selectedReasons.remove(reportReasons[index]);
                } else {
                  selectedReasons.add(reportReasons[index]);
                }
              });
            },
            title: Text(
              reportReasons[index],
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            checkColor: Colors.white,
            activeColor: DesignVariables.primaryRed,
          ),
          decoration:
              BoxDecoration(border: (index == 0) ? topBorder : standardBorder),
        ),
      );
    }

    return Scaffold(
      appBar: PushedScreenTopBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Report User",
                  style: headerStyle,
                ),
                smallSpacer,
                Text(
                  "Here at eUnity we strive to create a safe space where everybody is welcome to come to build relationships. If you believe this user is compromising that mission, then feel free to leave a report.",
                  style: normalStyle,
                  textAlign: TextAlign.center,
                ),
                largeSpacer,
                Text(
                  "Rules Violated",
                  style: headerStyle,
                  textAlign: TextAlign.center,
                ),
                smallSpacer,
                Text(
                  "Please select the reasons you are reporting this user",
                  style: normalStyle,
                ),
                smallSpacer,
                checkTile(0),
                checkTile(1),
                checkTile(2),
                checkTile(3),
                largeSpacer,
                Text(
                  "Additional Comments",
                  style: headerStyle,
                ),
                smallSpacer,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: textFieldDecorator,
                    height: 185,
                    width: double.infinity,
                    child: TextField(
                      controller: reportController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Type any additional comments here.",
                        hintStyle: hintStyle,
                        hintMaxLines: 100,
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
    reportController.dispose();
    super.dispose();
  }
}
