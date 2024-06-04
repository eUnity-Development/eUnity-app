import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eunity/views/Swiping.dart';
import 'package:eunity/views/PremiumFeatures.dart';
import 'package:eunity/views/Messages.dart';
import 'package:eunity/views/Profile.dart';
import 'package:eunity/widgets/TopBars/HomeTopBar.dart';
import 'package:eunity/classes/DesignVariables.dart';

class CoreTemplate extends StatefulWidget {
  const CoreTemplate({super.key});

  @override
  State<CoreTemplate> createState() => _CoreTemplateState();
}

class _CoreTemplateState extends State<CoreTemplate> {
  int selectedIndex = 0;
  bool colorRed = true;
  Color unselectedColor = Color.fromARGB(255, 56, 56, 56);
  Color selectedColor = DesignVariables.primaryRed;

  final screens = [
    const Swiping(),
    const PremiumFeatures(),
    const Messages(),
    const Profile(),
  ];

  void onItemTapped(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 734,
              width: 412,
              child: screens[selectedIndex],
            ),
          ],
        ),
      ),
      appBar: HomeTopBar(selectedIndex: selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 245, 245, 245),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xffFFE89A),
            unselectedItemColor: const Color(0xff89875A),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/NavBarUI/icon-heart.svg',
                      color: unselectedColor),
                ),
                activeIcon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/NavBarUI/icon-heart.svg',
                      color: selectedColor),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    'assets/NavBarUI/icon-sparkles.svg',
                    color: unselectedColor,
                  ),
                ),
                activeIcon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/NavBarUI/icon-sparkles.svg',
                      color: selectedColor),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                      'assets/NavBarUI/icon-chat-bubbles.svg',
                      color: unselectedColor),
                ),
                activeIcon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                      'assets/NavBarUI/icon-chat-bubbles.svg',
                      color: selectedColor),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/NavBarUI/icon-shadow.svg',
                      color: unselectedColor),
                ),
                activeIcon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/NavBarUI/icon-shadow.svg',
                      color: selectedColor),
                ),
                label: '',
              ),
            ],
            onTap: onItemTapped,
            currentIndex: selectedIndex),
      ),
    );
  }
}
