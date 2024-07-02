import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  final String confirmationTitle;
  final String confirmationBody;
  const ConfirmationScreen(
      {super.key,
      required this.confirmationTitle,
      required this.confirmationBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedScreenTopBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60, left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            (confirmationTitle != '')
                ? Text(
                    confirmationTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            (confirmationBody != '')
                ? Text(
                    confirmationBody,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )
                : SizedBox(),
            Spacer(),
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
                      "Go Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                ),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
