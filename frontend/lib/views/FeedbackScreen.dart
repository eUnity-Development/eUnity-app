import 'package:dio/dio.dart';
import 'package:eunity/classes/ReportHelper.dart';
import 'package:eunity/views/ConfirmationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int starRating = 0;
  TextEditingController positiveController = TextEditingController();
  TextEditingController negativeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle =
        TextStyle(fontWeight: FontWeight.w700, fontSize: 18);

    const TextStyle hintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Color.fromARGB(128, 0, 0, 0));

    Stack filledStar = Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          child: SvgPicture.asset("assets/MiscIcons/icon-filled-star.svg"),
          height: 52,
        ),
        SizedBox(
          child: SvgPicture.asset("assets/MiscIcons/icon-outline-star.svg"),
          height: 58,
        ),
      ],
    );

    SizedBox outlineStar = SizedBox(
      child: SvgPicture.asset("assets/MiscIcons/icon-outline-star.svg"),
      height: 58,
    );

    Row fiveStars = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: (starRating >= 1) ? filledStar : outlineStar,
          onTap: () {
            setState(() {
              starRating = 1;
            });
          },
        ),
        GestureDetector(
          child: (starRating >= 2) ? filledStar : outlineStar,
          onTap: () {
            setState(() {
              starRating = 2;
            });
          },
        ),
        GestureDetector(
          child: (starRating >= 3) ? filledStar : outlineStar,
          onTap: () {
            setState(() {
              starRating = 3;
            });
          },
        ),
        GestureDetector(
          child: (starRating >= 4) ? filledStar : outlineStar,
          onTap: () {
            setState(() {
              starRating = 4;
            });
          },
        ),
        GestureDetector(
          child: (starRating >= 5) ? filledStar : outlineStar,
          onTap: () {
            setState(() {
              starRating = 5;
            });
          },
        ),
      ],
    );

    const SizedBox largeSpacer = SizedBox(
      height: 20,
    );

    const SizedBox smallSpacer = SizedBox(
      height: 10,
    );

    BoxDecoration textFieldDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    Future<void> submitFeedback(
        int starRating, String positiveText, String negativeText) async {
      Response response = await ReportHelper.submitFeedback(
          starRating, positiveText, negativeText);
      print(response);
    }

    void navigateToConfirmationScreen() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const Scaffold(
              body: ConfirmationScreen(
                confirmationTitle: "Thank you for submitting your feedback!",
                confirmationBody:
                    "At eUnity, our user's experiences are always important to us. Thank you for sharing yours with us. We will do our best to ensure it is heard and your concerns are addressed as quickly as possible.",
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: PushedScreenTopBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              largeSpacer,
              Text(
                "How are we doing?",
                style: headerStyle,
              ),
              largeSpacer,
              fiveStars,
              smallSpacer,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "At eUnity, your user experience is paramount to us. Please, rate us on a scale of 5 stars.",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              largeSpacer,
              Text("What are we doing correctly?", style: headerStyle),
              smallSpacer,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: textFieldDecorator,
                  height: 185,
                  width: double.infinity,
                  child: TextField(
                    controller: positiveController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText:
                          "At eUnity, we always strive to build an app that works for you. If there’s features that work well for you or you wish to see us expand on more, please, let us know by typing here!",
                      hintStyle: hintStyle,
                      hintMaxLines: 100,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              largeSpacer,
              Text("What needs more work?", style: headerStyle),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: textFieldDecorator,
                  height: 185,
                  width: double.infinity,
                  child: TextField(
                    controller: negativeController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText:
                          "Building relationships takes a lot of work, and is always an ongoing process. At eUnity, we believe building our tools to assist you in building strong relationships works the same way. If there’s anything we can do or change to help serve your needs better, please, let us know by typing here!",
                      hintStyle: hintStyle,
                      hintMaxLines: 100,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              largeSpacer,
              largeSpacer,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
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
                        "Submit Feedback",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (starRating > 0) {
                      await submitFeedback(starRating, positiveController.text,
                          negativeController.text);
                      navigateToConfirmationScreen();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please add a star rating in order to submit your feedback!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    positiveController.dispose();
    negativeController.dispose();
    super.dispose();
  }
}
