import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';

class PremiumAd extends StatelessWidget {
  const PremiumAd({super.key});


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
          Image.asset("assets/premium/premium-logo.png")
        ],
      )
    );
  }
}
