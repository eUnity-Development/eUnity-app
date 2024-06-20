import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/TopBars/NoLogoTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24);

    BoxDecoration boxStyle = BoxDecoration(
        color: Color.fromARGB(153, 233, 233, 233),
        borderRadius: BorderRadius.circular(25));

    Widget settingsTile(bool hasTop, String title) {
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
                "assets/MiscIcons/icon-gear.svg",
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
              SvgPicture.asset("assets/NavBarUI/icon-chevron-right.svg")
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
      appBar: NoLogoTopBar(title: 'Settings'),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account",
              style: headerStyle,
            ),
            boxSpacer,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 190,
                decoration: boxStyle,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      settingsTile(false, "Preferences"),
                      settingsTile(true, "Notifications"),
                      settingsTile(true, "Membership"),
                      settingsTile(true, "Terms and Conditions")
                    ],
                  ),
                ),
              ),
            ),
            largeSpacer,
            Text(
              "Support",
              style: headerStyle,
            ),
            boxSpacer,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 145,
                decoration: boxStyle,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      settingsTile(false, "Privacy"),
                      settingsTile(true, "Help Center"),
                      settingsTile(true, "About Us"),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: DesignVariables.offWhite,
                    borderRadius: BorderRadius.circular(25),
                    border:
                        Border.all(color: DesignVariables.greyLines, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                ),
                onTap: () {
                  print("Clicked Logout");
                },
              ),
            ),
            largeSpacer,
            largeSpacer,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: DesignVariables.primaryRed,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                ),
                onTap: () {
                  print("Clicked Delete Account");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
