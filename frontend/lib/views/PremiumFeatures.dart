import 'package:flutter/material.dart';
import 'package:frontend/classes/DesignVariables.dart';
import 'package:frontend/views/OtherPremiumFeatures.dart';
import 'package:frontend/views/PeopleThatLikeYou.dart';

class PremiumFeatures extends StatefulWidget {
  const PremiumFeatures({super.key});

  @override
  State<PremiumFeatures> createState() => _CreatePostState();
}

class _CreatePostState extends State<PremiumFeatures> {
  int selectedIndex = 0;

  final screens = [
    const PeopleThatLikeYou(),
    const OtherPremiumFeatures(),
  ];

  void changeScreen(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color unselectedColor = Color.fromARGB(128, 0, 0, 0);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          SizedBox(
            height: 21,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Text(
                      "4 People Like You",
                      style: TextStyle(
                          color: (selectedIndex == 0)
                              ? DesignVariables.primaryRed
                              : unselectedColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        changeScreen(0);
                      });
                    },
                  ),
                ),
              ),
              Container(height: 40, width: 1, color: DesignVariables.greyLines),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Text(
                      "Other Premium Features",
                      style: TextStyle(
                          color: (selectedIndex == 1)
                              ? DesignVariables.primaryRed
                              : unselectedColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        changeScreen(1);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          Container(height: 1, color: DesignVariables.greyLines),
          Expanded(
            child: screens[selectedIndex],
          )
        ],
      ),
    );
  }
}
