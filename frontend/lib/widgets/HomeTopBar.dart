import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTopBar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  const HomeTopBar({super.key, required this.selectedIndex});

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeTopBarState extends State<HomeTopBar> {
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
      actions: [
        Row(
          children: [
            (widget.selectedIndex == 0)
                ? IconButton(
                    icon: SvgPicture.asset(
                      'assets/NavBarUI/icon-adjustments.svg',
                      width: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        print('Clicked');
                      });
                    },
                  )
                : const SizedBox(),
            IconButton(
              icon: SvgPicture.asset('assets/NavBarUI/icon-bell.svg'),
              onPressed: () {
                setState(() {
                  print("Clicked.");
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
