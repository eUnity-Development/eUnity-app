import 'package:eunity/classes/DesignVariables.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageContent;
  final bool sentByUser;
  final bool isTopStack;
  const MessageBubble(
      {super.key,
      required this.messageContent,
      required this.sentByUser,
      required this.isTopStack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Align(
        alignment: (sentByUser ? Alignment.centerRight : Alignment.centerLeft),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: (sentByUser
                    ? DesignVariables.primaryRed
                    : DesignVariables.greyLines),
                borderRadius: (isTopStack)
                    ? BorderRadius.all(Radius.circular(12))
                    : BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: (sentByUser
                            ? Radius.circular(0)
                            : Radius.circular(12)),
                        bottomLeft: (sentByUser
                            ? Radius.circular(12)
                            : Radius.circular(0)),
                      )),
            child: Text(
              messageContent,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: (sentByUser ? Colors.white : Colors.black)),
            )),
      ),
    );
  }
}
