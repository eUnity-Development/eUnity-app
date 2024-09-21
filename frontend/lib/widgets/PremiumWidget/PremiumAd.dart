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
        height: 20,
        width: 20,
      );
    }

    Widget x = svg('assets/premium/x.svg');
    Widget checkmark = svg('assets/premium/check.svg');

    Widget tableText(String text, [bool isHeader = false, bool isGold = false]) {
      return Text(
            text,
            style: isHeader
                ? TextStyle(
                    fontWeight: FontWeight.w700, color: isGold ? DesignVariables.gold : Colors.black)
                : const TextStyle()
          );
    }

    Widget tableEntry(dynamic content, [bool isLast = false, bool isHeader = false]) {
      double boxHeight = 0;
      if (isHeader) {
        boxHeight = 4;
      } else if (!isLast) {
        boxHeight = 2;
      }
      return Column(
        children: [
          content,
          SizedBox(height: boxHeight)
        ]
      );
    }


    return Container(
      width: 349 * DesignVariables.widthConversion,
      height: 389 * DesignVariables.heightConversion,
      decoration: BoxDecoration(
        border: Border.all(color: DesignVariables.greyLines),
        borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20 * DesignVariables.widthConversion),
          Image.asset("assets/premium/premium-logo.png"),
          const Spacer(),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30 * DesignVariables.widthConversion),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Included
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tableEntry(tableText('Included', true), false, true),
                        tableEntry(tableText('Feature 1')),
                        tableEntry(tableText('Feature 2')),
                        tableEntry(tableText('Feature 3')),
                        tableEntry(tableText('Feature 4')),
                        tableEntry(tableText('Feature 5'), true),
                      ],
                    ),

                    // Free
                    Column(
                      children: [
                        tableEntry(tableText('Free', true), false, true),
                        tableEntry(x),
                        tableEntry(x),
                        tableEntry(x),
                        tableEntry(x),
                        tableEntry(x, true),
                      ],
                    ),

                    // Premium
                    Column(
                      children: [
                        tableEntry(tableText('Premium', true, true), false, true),
                        tableEntry(checkmark),
                        tableEntry(checkmark),
                        tableEntry(checkmark),
                        tableEntry(checkmark),
                        tableEntry(checkmark, true),
                      ],
                    )
                  ]),
            ),

          const Spacer(),
          LoginSignupButton(
            color: DesignVariables.gold, 
            onTap: purchase, 
            borderColor: Colors.transparent, 
            height: 53, 
            width: 189, 
            buttonContent: 
              const Text(
                "Upgrade",
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )
              )
          ),
          SizedBox(height: 20 * DesignVariables.widthConversion),
        ],
        
      )
    );
  }
}
