import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:eunity/widgets/PremiumWidgets/PremiumList.dart';
import 'package:eunity/widgets/TopBars/PushedScreenTopBar.dart';
import 'package:flutter/material.dart';

class PurchasePremium extends StatelessWidget {
  const PurchasePremium({super.key});

  @override
  Widget build(BuildContext context) {
    const double price = 4.99;

    void buy() {
      print('BUY BUY BUY');
    }

    const TextStyle textIntable = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20);
    SizedBox gap(int x) {
      return SizedBox(height: x * DesignVariables.heightConversion);
    }

    return Scaffold(
        appBar: const PushedScreenTopBar(isPremium: true),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    gap(70),
                    const Text(
                      'Purchase Premium Plan',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                    gap(20),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Gain access to exclusive premium features and help support eUnity\'s development!',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          textAlign: TextAlign.center,
                        )),
                    gap(40),
                    Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: DesignVariables.greyLines),
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(children: [
                              const PremiumList(),
                              gap(40),
                              const Text('\$$price/month', style: textIntable),
                              const Text(
                                'Cancel anytime',
                                style: textIntable,
                              ),
                            ]))),
                    gap(80),
                    LoginSignupButton(
                        color: DesignVariables.gold,
                        onTap: buy,
                        borderColor: Colors.transparent,
                        height: 52 * DesignVariables.heightConversion,
                        width: 334 * DesignVariables.widthConversion,
                        buttonContent: const Text("Buy Now",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ))),
                  ],
                ))));
  }
}
