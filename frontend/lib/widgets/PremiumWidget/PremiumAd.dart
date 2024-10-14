import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PremiumAd extends StatelessWidget {
  const PremiumAd({super.key});

  void purchase() {
    // Go to a screen to actually purchase premium
    print("BUY BUY BUY");
  }

  @override
  Widget build(BuildContext context) {
    Widget svg(String path) {
      return SvgPicture.asset(
        path,
        height: 23.5,
        width: 23.5,
      );
    }

    Widget x = svg('assets/premium/x.svg');
    Widget checkmark = svg('assets/premium/check.svg');

    Widget tableText(String text,
        [bool isHeader = false, bool isGold = false]) {
      return Padding(
          padding: EdgeInsets.only(bottom: isHeader ? 5.0 : 0.0),
          child: Text(text,
              textAlign: text == 'Included' ? TextAlign.left : TextAlign.center,
              style: isHeader
                  ? TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isGold ? DesignVariables.gold : Colors.black,
                      fontSize: 17)
                  : const TextStyle(fontSize: 17)));
    }

    TableRow tableRow(String feature, [bool isLast = false]) {
      double bottomPadding = isLast ? 0.0 : 3.0;
      return TableRow(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: tableText(feature),
          ),
          Center(
            child: x,
          ),
          Center(
            child: checkmark,
          ),
        ],
      );
    }

    return Container(
        width: 349 * DesignVariables.widthConversion,
        height: 389 * DesignVariables.heightConversion,
        decoration: BoxDecoration(
            border: Border.all(color: DesignVariables.greyLines),
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20 * DesignVariables.widthConversion),
            Image.asset("assets/premium/premium-logo.png"),
            const Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30 * DesignVariables.widthConversion),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        tableText('Included', true),
                        tableText('Free', true, true),
                        tableText('Premium', true, true),
                      ],
                    ),
                    tableRow('Feature #1'),
                    tableRow('Feature #2'),
                    tableRow('Feature #3'),
                    tableRow('Feature #4'),
                    tableRow('Feature #5', true),
                  ],
                )),
            const Spacer(),
            LoginSignupButton(
                color: DesignVariables.gold,
                onTap: purchase,
                borderColor: Colors.transparent,
                height: 45,
                width: 189,
                buttonContent: const Text("Upgrade",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ))),
            SizedBox(height: 20 * DesignVariables.widthConversion),
          ],
        ));
  }
}
