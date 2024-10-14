import 'package:eunity/views/PurchasePremium.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/PremiumWidgets/PremiumList.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';

class PremiumAd extends StatelessWidget {
  const PremiumAd({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToPurchase() async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PurchasePremium()),
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
            SizedBox(
              width: 200,
              child: Image.asset("assets/premium/premium-logo.png"),
            ),
            const Spacer(),
            const PremiumList(),
            const Spacer(),
            LoginSignupButton(
                color: DesignVariables.gold,
                onTap: navigateToPurchase,
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
