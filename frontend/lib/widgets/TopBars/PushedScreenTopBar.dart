import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PushedScreenTopBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? hasArrow;
  const PushedScreenTopBar({super.key, this.hasArrow});

  @override
  State<PushedScreenTopBar> createState() => _PushedScreenTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PushedScreenTopBarState extends State<PushedScreenTopBar> {
  @override
  Widget build(BuildContext context) {
    bool hasArrow = widget.hasArrow ?? true;

    return AppBar(
      title: Stack(
        children: [
          if (hasArrow)
          Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(
                child: SizedBox(
                  child:
                      SvgPicture.asset("assets/NavBarUI/icon-arrow-left.svg"),
                  height: 40,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )),
          Container(
            child: Center(
              child: SizedBox(
                width: 120,
                child: Image.asset("assets/e-unity-logo-and-name.png"),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
    );
  }
}
