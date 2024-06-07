import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eunity/views/MatchPreferences.dart';
import 'package:eunity/views/Notifications.dart';

class HomeTopBar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  const HomeTopBar({super.key, required this.selectedIndex});

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeTopBarState extends State<HomeTopBar> {
  void navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Notifications()),
    );
  }

  void navigateToMatchPreferences() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MatchPreferences()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(children: [
        SizedBox(
          width: 120,
          child: Image.asset("assets/e-unity-logo-and-name.png"),
        ),
        SizedBox(
          width: 5,
        ),
      ]),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      surfaceTintColor: Colors.transparent,
      actions: [
        Row(
          children: [
            (widget.selectedIndex == 0)
                ? IconButton(
                    icon: SvgPicture.asset(
                      'assets/NavBarUI/icon-adjustments.svg',
                      width: 35,
                    ),
                    onPressed: navigateToMatchPreferences,
                  )
                : const SizedBox(),
            IconButton(
              icon: SvgPicture.asset('assets/NavBarUI/icon-bell.svg'),
              onPressed: navigateToNotifications,
            ),
          ],
        )
      ],
    );
  }
}
