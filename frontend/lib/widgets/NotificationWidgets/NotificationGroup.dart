import 'package:flutter/material.dart';
import 'package:frontend/classes/DesignVariables.dart';
import 'package:frontend/widgets/NotificationWidgets/NotificationTile.dart';

class NotificationGroup extends StatelessWidget {
  final List notificationList;
  final String groupLabel;
  const NotificationGroup(
      {super.key, required this.notificationList, required this.groupLabel});

  @override
  Widget build(BuildContext context) {
    List<Widget> notificationWidgets = [];

    Widget grayLine = Container(
      height: 1,
      width: double.infinity,
      color: DesignVariables.greyLines,
    );

    Widget heightSpacer = SizedBox(
      height: 16,
    );

    notificationWidgets.add(heightSpacer);

    notificationWidgets.add(Text(
      this.groupLabel,
      style: TextStyle(
          color: Color.fromARGB(128, 0, 0, 0),
          fontWeight: FontWeight.w300,
          fontSize: 15),
    ));

    notificationWidgets.add(grayLine);
    notificationWidgets.add(heightSpacer);

    for (var map in notificationList) {
      notificationWidgets.add(NotificationTile(notificationData: map));
      notificationWidgets.add(heightSpacer);
    }

    notificationWidgets.add(grayLine);

    return Column(
      children: notificationWidgets,
    );
  }
}
