import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/MessageWidgets/MessageBubble.dart';
import 'package:eunity/widgets/TopBars/MessagesTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessagingScreen extends StatefulWidget {
  final String matchPfp;
  final String matchName;
  const MessagingScreen(
      {super.key, required this.matchPfp, required this.matchName});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Map<dynamic, dynamic>> messageHistory = [];

  @override
  void initState() {
    super.initState();
    loadMessageData();
  }

  void scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void loadMessageData() {
    Map<dynamic, dynamic> message1 = {'content': 'Hello', 'sentByUser': true};
    Map<dynamic, dynamic> message2 = {
      'content': 'I\'m testing some messaging in flutter.',
      'sentByUser': true
    };
    Map<dynamic, dynamic> message3 = {
      'content': 'Oh cool.',
      'sentByUser': false
    };
    Map<dynamic, dynamic> message4 = {
      'content': 'How is it going?',
      'sentByUser': false
    };
    Map<dynamic, dynamic> message5 = {
      'content': 'I think it\'s going pretty alright',
      'sentByUser': true
    };
    Map<dynamic, dynamic> message6 = {'content': 'Sick.', 'sentByUser': false};

    messageHistory
        .addAll([message1, message2, message3, message4, message5, message6]);
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle hintStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color.fromARGB(128, 0, 0, 0));

    const TextStyle counterStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.red,
    );

    BoxDecoration textFieldDecorator = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: DesignVariables.greyLines));

    Widget placedBubble(int index) {
      Map<dynamic, dynamic> specificMessage = messageHistory[index];
      if (specificMessage['sentByUser']) {
        if (index == messageHistory.length - 1 ||
            messageHistory[index + 1]['sentByUser'] == false) {
          return MessageBubble(
            messageContent: specificMessage['content'],
            sentByUser: true,
            isTopStack: false,
          );
        }
        return MessageBubble(
          messageContent: specificMessage['content'],
          sentByUser: true,
          isTopStack: true,
        );
      }
      if (index == messageHistory.length - 1 ||
          messageHistory[index + 1]['sentByUser']) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
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
                  radius: 16,
                ),
              ),
            ),
            MessageBubble(
              messageContent: specificMessage['content'],
              sentByUser: false,
              isTopStack: false,
            ),
          ],
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: MessageBubble(
          messageContent: specificMessage['content'],
          sentByUser: false,
          isTopStack: true,
        ),
      );
    }

    return Scaffold(
      appBar: MessagesTopBar(
          matchPfp: widget.matchPfp, matchName: widget.matchName),
      body: Column(children: [
        SizedBox(
          height: 5,
        ),
        Container(
          color: DesignVariables.greyLines,
          width: double.infinity,
          height: 1,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index < messageHistory.length) {
                return placedBubble(index);
              }
              return null;
            },
            controller: scrollController,
          ),
        ),
        Container(
            height: 1,
            width: double.infinity,
            color: DesignVariables.greyLines),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 80,
                    ),
                    child: IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: textFieldDecorator,
                        child: TextField(
                          controller: textController,
                          maxLines: null,
                          maxLength: 250,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintText: "Type Message Here",
                              hintStyle: hintStyle,
                              hintMaxLines: 100,
                              border: InputBorder.none,
                              counterText: (textController.text.length >= 250)
                                  ? "Character Limit Reached"
                                  : "",
                              counterStyle: counterStyle),
                          onChanged: (String newText) {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              child: SvgPicture.asset(
                "assets/MiscIcons/icon-paper-airplane.svg",
                height: 40,
                color: (textController.text == '')
                    ? DesignVariables.greyLines
                    : DesignVariables.primaryRed,
              ),
              onTap: () {
                bool needsScroll = false;
                if (mounted) {
                  setState(() {
                    if (textController.text != '') {
                      Map<dynamic, dynamic> newMessage = {
                        'content': textController.text,
                        'sentByUser': true
                      };
                      messageHistory.add(newMessage);
                      textController.clear();
                      needsScroll = true;
                    }
                  });
                }

                if (needsScroll && mounted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollToBottom();
                  });
                }
              },
            )
          ],
        )
      ]),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
