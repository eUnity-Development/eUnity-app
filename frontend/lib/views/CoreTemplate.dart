import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/views/ScreenOne.dart';
import 'package:frontend/views/ScreenTwo.dart';
import 'package:frontend/views/ScreenThree.dart';
import 'package:frontend/views/ScreenFour.dart';
import 'package:frontend/views/ScreenFive.dart';

class CoreTemplate extends StatefulWidget {
  const CoreTemplate({super.key});

  @override
  State<CoreTemplate> createState() => _CoreTemplateState();
}

class _CoreTemplateState extends State<CoreTemplate> {
  int selectedIndex = 0;
  final screens = [
    const ScreenOne(),
    const ScreenTwo(),
    const ScreenThree(),
    const ScreenFour(),
    const ScreenFive(),
  ];

  void onItemTapped(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color unselectedColor = Color.fromARGB(255, 56, 56, 56);
    Color selectedColor = Color.fromARGB(255, 247, 112, 112);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: Image.asset("assets/e-unity-logo.png"),
            ),
            Container(
              height: 1.0, // Set the desired height of the line
              color: const Color(0x5f000000),
              margin: const EdgeInsets.symmetric(vertical: 0),
            ),
            SizedBox(
              height: 734,
              width: 412,
              child: screens[selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 232, 232, 232),
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
                    'assets/NavBarUI/icon-magnifying-glass.svg',
                    color: unselectedColor,
                  ),
                ),
                activeIcon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                      'assets/NavBarUI/icon-magnifying-glass.svg',
                      color: selectedColor),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/NavBarUI/icon-sparkles.svg',
                      color: unselectedColor),
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
                  child: SvgPicture.asset(
                    'assets/NavBarUI/icon-shadow.svg',
                    color: unselectedColor,
                  ),
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
