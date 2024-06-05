import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/views/Messages.dart';
import 'package:frontend/views/PremiumFeatures.dart';
import 'package:frontend/views/Profile.dart';
import 'package:frontend/views/Swiping.dart';
import 'package:frontend/widgets/TopBars/HomeTopBar.dart';

class CoreTemplate extends StatefulWidget {
  const CoreTemplate({super.key});

  @override
  State<CoreTemplate> createState() => _CoreTemplateState();
}

class _CoreTemplateState extends State<CoreTemplate> {
  int selectedIndex = 0;
  Color unselectedColor = Colors.grey;
  Color selectedColor = Colors.white;

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
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: screens[selectedIndex],
      appBar: HomeTopBar(selectedIndex: selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 70,
        index: selectedIndex,
        items: <Widget>[
          SvgPicture.asset(
            'assets/NavBarUI/icon-heart.svg',
            color: selectedIndex == 0 ? selectedColor : unselectedColor,
            width: 30,
            height: 30,
          ),
          SvgPicture.asset(
            'assets/NavBarUI/icon-sparkles.svg',
            color: selectedIndex == 1 ? selectedColor : unselectedColor,
            width: 30,
            height: 30,
          ),
          SvgPicture.asset(
            'assets/NavBarUI/icon-chat-bubbles.svg',
            color: selectedIndex == 2 ? selectedColor : unselectedColor,
            width: 30,
            height: 30,
          ),
          SvgPicture.asset(
            'assets/NavBarUI/icon-shadow.svg',
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

