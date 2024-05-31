import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/classes/DesignVariables.dart';

class NotificationTile extends StatelessWidget {
  final Map<String, String> notificationData;
  const NotificationTile({super.key, required this.notificationData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: DesignVariables.offWhite,
          border: Border.all(color: Color.fromARGB(128, 0, 0, 0), width: 1),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(64, 0, 0, 0),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        width: double.infinity,
        height: 104,
        child: Column(children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(64, 0, 0, 0),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(notificationData['imageURL']!),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      notificationData['title']!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  notificationData['timestamp']!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(128, 0, 0, 0),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  child: Row(children: [
                    Text(
                      notificationData['goTo']!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      child: SvgPicture.asset(
                          "assets/NavBarUI/icon-chevron-right.svg"),
                      height: 20,
                      width: 20,
                    )
                  ]),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
