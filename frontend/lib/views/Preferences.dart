import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/NoLogoTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24);

    BoxDecoration boxStyle = BoxDecoration(
        color: Color.fromARGB(153, 233, 233, 233),
        borderRadius: BorderRadius.circular(25));

    Widget prefsTile(
        bool hasTop, String title, String iconName, bool isSwitch) {
      return Column(
        children: [
          (hasTop)
              ? Container(
                  color: DesignVariables.greyLines,
                  height: 1,
                  width: double.infinity,
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/MiscIcons/icon-${iconName}.svg",
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              Spacer(),
              (isSwitch)
                  ? Switch(
                      value: _isOn,
                      onChanged: (value) {
                        setState(() {
                          _isOn = value;
                        });
                      },
                      activeColor: DesignVariables.primaryRed,
                      inactiveTrackColor: DesignVariables.greyLines,
                      inactiveThumbColor: Colors.black,
                    )
                  : SvgPicture.asset("assets/NavBarUI/icon-chevron-right.svg")
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
    }

    SizedBox boxSpacer = const SizedBox(
      height: 10,
    );

    SizedBox largeSpacer = const SizedBox(
      height: 10,
    );

    return Scaffold(
      appBar: NoLogoTopBar(title: 'Preferences'),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Localization",
              style: headerStyle,
            ),
            prefsTile(true, "Distance Unit", "gear", false),
            prefsTile(true, "Height Unit", "gear", false),
            prefsTile(true, 'Language', 'language', false),
            largeSpacer,
            Text(
              "Personalization",
              style: headerStyle,
            ),
            prefsTile(true, "App Theme", "paint-brush", false),
            largeSpacer,
            Text(
              "??? Category",
              style: headerStyle,
            ),
            prefsTile(true, "Switchy Thing", "gear", true),
          ],
        ),
      ),
    );
  }
}
