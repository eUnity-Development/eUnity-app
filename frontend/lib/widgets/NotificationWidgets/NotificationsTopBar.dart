import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsTopBar extends StatefulWidget
    implements PreferredSizeWidget {
  const NotificationsTopBar({super.key});

  @override
  State<NotificationsTopBar> createState() => _NotificationsTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NotificationsTopBarState extends State<NotificationsTopBar> {
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
                    child: SvgPicture.asset("assets/NavBarUI/icon-bell.svg"),
                    height: 30,
                  ),
                  Text(
                    "Recent Notifications",
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
