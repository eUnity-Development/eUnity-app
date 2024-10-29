import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PremiumList extends StatelessWidget {
  const PremiumList({super.key});

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
              textAlign: text != 'Free' && text != 'Premium'
                  ? TextAlign.left
                  : TextAlign.center,
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

    return Padding(
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
        ));
  }
}
