import 'package:eunity/views/ReportUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessagesTopBar extends StatefulWidget implements PreferredSizeWidget {
  final String matchPfp;
  final String matchName;
  MessagesTopBar({super.key, required this.matchPfp, required this.matchName});

  @override
  State<MessagesTopBar> createState() => _MessagesTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MessagesTopBarState extends State<MessagesTopBar> {
  @override
  Widget build(BuildContext context) {
    void navigateToReportTest() async {
      print('clicked report');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReportUser()),
      );
    }

    return AppBar(
      title: Stack(
        children: [
          Positioned(
              left: 0,
              top: 8,
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
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(64, 0, 0, 0),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(widget.matchPfp),
                        radius: 23,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.matchName,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.black),
                    )
                  ]),
            ),
          ),
          Positioned(
            right: 0,
            top: 13,
            child: GestureDetector(
              child: SvgPicture.asset(
                "assets/MiscIcons/icon-3dots.svg",
                height: 30,
              ),
              onTap: navigateToReportTest,
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
