import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PushedScreenWithIconTopBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String assetPath;
  final String title;
  const PushedScreenWithIconTopBar(
      {super.key, required this.assetPath, required this.title});

  @override
  State<PushedScreenWithIconTopBar> createState() =>
      _PushedScreenWithIconTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PushedScreenWithIconTopBarState
    extends State<PushedScreenWithIconTopBar> {
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
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: SvgPicture.asset(widget.assetPath),
                    height: 30,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
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
