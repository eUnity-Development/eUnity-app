import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/views/Swiping.dart';
import 'package:frontend/views/PremiumFeatures.dart';
import 'package:frontend/views/Messages.dart';
import 'package:frontend/views/Profile.dart';

class CoreTemplate extends StatefulWidget {
  const CoreTemplate({super.key});

  @override
  State<CoreTemplate> createState() => _CoreTemplateState();
}

class _CoreTemplateState extends State<CoreTemplate> {
  int selectedIndex = 0;
  bool colorRed = true;
  Color unselectedColor = Color.fromARGB(255, 56, 56, 56);
  Color selectedColor = Color.fromARGB(255, 247, 112, 112);

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
      appBar: AppBar(
        title: Row(children: [
          SizedBox(
            height: 50,
            width: 50,
            child: colorRed
                ? Image.asset("assets/e-unity-logo.png")
                : Image.asset("assets/alt-e-unity-logo.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "eUnity",
            style: TextStyle(color: selectedColor, fontWeight: FontWeight.bold),
          )
        ]),
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        actions: [
          SizedBox(
            child: IconButton(
              icon: SvgPicture.asset('assets/NavBarUI/icon-bell.svg'),
              onPressed: () {
                setState(() {
                  colorRed
                      ? selectedColor = Color.fromARGB(255, 2, 162, 236)
                      : selectedColor = Color.fromARGB(255, 247, 112, 112);
                  colorRed = !colorRed;
                });
              },
            ),
          )
        ],
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
