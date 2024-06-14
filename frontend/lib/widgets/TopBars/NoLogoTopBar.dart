import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoLogoTopBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const NoLogoTopBar({super.key, required this.title});

  @override
  State<NoLogoTopBar> createState() => _NoLogoTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NoLogoTopBarState extends State<NoLogoTopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(
        children: [
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
              child: Text(
                widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.black),
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
