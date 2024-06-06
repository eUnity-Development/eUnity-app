import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/views/Messages.dart';
import 'package:eunity/views/PremiumFeatures.dart';
import 'package:eunity/views/Profile.dart';
import 'package:eunity/views/Swiping.dart';
import 'package:eunity/widgets/TopBars/HomeTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoreTemplate extends StatefulWidget {
  const CoreTemplate({super.key});

  @override
  State<CoreTemplate> createState() => _CoreTemplateState();
}

class _CoreTemplateState extends State<CoreTemplate> {
  int selectedIndex = 0;
  Color unselectedColor = DesignVariables.greyLines;
  Color selectedColor = DesignVariables.primaryRed;

  final screens = [
    const Swiping(),
    const PremiumFeatures(),
    const Messages(),
    const Profile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 232, 232),
      body: screens[selectedIndex],
      appBar: HomeTopBar(selectedIndex: selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 232, 232, 232),
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 75,
        index: selectedIndex,
        items: <Widget>[
          SvgPicture.asset(
            selectedIndex == 0
              ? 'assets/NavBarUI/icon-filled-heart.svg'
              : 'assets/NavBarUI/icon-heart.svg',
            color: selectedIndex == 0 ? selectedColor : unselectedColor,
            width: 30,
            height: 30,
          ),
          SvgPicture.asset(
            selectedIndex == 1
              ? 'assets/NavBarUI/icon-filled-sparkles.svg'
              : 'assets/NavBarUI/icon-sparkles.svg',
            color: selectedIndex == 1 ? selectedColor : unselectedColor,
            width: 30,
            height: 30,
          ),
          SvgPicture.asset(
            selectedIndex == 2
              ? 'assets/NavBarUI/icon-filled-chat-bubbles.svg'
              : 'assets/NavBarUI/icon-chat-bubbles.svg',
            color: selectedIndex == 2 ? selectedColor : unselectedColor,
            width: 30,
            height: 30,
          ),
          SvgPicture.asset(
            selectedIndex == 3
              ? 'assets/NavBarUI/icon-filled-shadow.svg'
              : 'assets/NavBarUI/icon-shadow.svg',
            color: selectedIndex == 3 ? selectedColor : unselectedColor,
            width: 30,
            height: 30,
          ),
        ],
        onTap: onItemTapped,
      ),
    );
  }
}
