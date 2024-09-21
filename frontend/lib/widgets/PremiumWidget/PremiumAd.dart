import 'package:eunity/views/LoginSignup.dart';
import 'package:eunity/widgets/LoginSignup/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';

class PremiumAd extends StatelessWidget {
  const PremiumAd({super.key});

  void purchase() {
    // Go to a screen to actually purchase premium
    print("BUY BUY BUY");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 349 * DesignVariables.widthConversion,
      height: 389 * DesignVariables.heightConversion,
      decoration: BoxDecoration(
        border: Border.all(color: DesignVariables.greyLines),
        borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        children: [
          SizedBox(height: 20 * DesignVariables.widthConversion),
          Image.asset("assets/premium/premium-logo.png"),
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
