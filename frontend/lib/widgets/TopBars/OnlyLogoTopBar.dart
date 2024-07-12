import 'package:flutter/material.dart';

class OnlyLogoTopBar extends StatefulWidget implements PreferredSizeWidget {
  const OnlyLogoTopBar({super.key});

  @override
  State<OnlyLogoTopBar> createState() => _OnlyLogoTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OnlyLogoTopBarState extends State<OnlyLogoTopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: SizedBox(
          width: 120,
          child: Image.asset("assets/e-unity-logo-and-name.png"),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      surfaceTintColor: Colors.transparent,
    );
  }
}
