import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eunity/classes/DesignVariables.dart';

class SelectionDialog extends StatefulWidget {
  final List options;
  final String question;
  final String assetPath;
  final bool multiSelect;
  final String cacheKey;
  const SelectionDialog(
      {super.key,
      required this.options,
      required this.question,
      required this.assetPath,
      required this.multiSelect,
      required this.cacheKey});

  @override
  State<SelectionDialog> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  @override
  Widget build(BuildContext context) {
    const TextStyle questionSyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24);

    BoxDecoration selectedBox = BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: Colors.white,
      border: Border.all(color: DesignVariables.primaryRed, width: 1),
    );

    BoxDecoration unselectedBox = BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: Colors.white,
      border: Border.all(color: DesignVariables.greyLines, width: 1),
    );

    TextStyle selectedText = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: DesignVariables.primaryRed);

    TextStyle unselectedText = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);

    return Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: SvgPicture.asset(
                    "assets/MiscIcons/icon-x.svg",
                    height: 30,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                (widget.assetPath == 'None')
                    ? SizedBox()
                    : SvgPicture.asset(
                        widget.assetPath,
                        height: 31,
                        width: 31,
                      ),
                Text(
                  widget.question,
                  style: questionSyle,
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index > (widget.options.length) - 1) {
                      return null;
                    }
                    return GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, left: 40, right: 40),
                        child: Container(
                          width: double.infinity,
                          height: 42,
                          decoration: (widget.multiSelect)
                              ? (UserInfoHelper.userInfoCache[widget.cacheKey]
                                      .contains(widget.options[index]))
                                  ? selectedBox
                                  : unselectedBox
                              : (UserInfoHelper
                                          .userInfoCache[widget.cacheKey] ==
                                      widget.options[index])
                                  ? selectedBox
                                  : unselectedBox,
                          child: Center(
                            child: Text(
                              widget.options[index],
                              style: (widget.multiSelect)
                                  ? (UserInfoHelper
                                          .userInfoCache[widget.cacheKey]
                                          .contains(widget.options[index]))
                                      ? selectedText
                                      : unselectedText
                                  : (UserInfoHelper
                                              .userInfoCache[widget.cacheKey] ==
                                          widget.options[index])
                                      ? selectedText
                                      : unselectedText,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (widget.multiSelect) {
                            List cacheValue =
                                UserInfoHelper.userInfoCache[widget.cacheKey];
                            if (cacheValue.contains(widget.options[index])) {
                              cacheValue.remove(widget.options[index]);
                            } else {
                              cacheValue.add(widget.options[index]);
                            }
                            UserInfoHelper.updateCacheVariable(
                                widget.cacheKey, cacheValue);
                          } else {
                            UserInfoHelper.updateCacheVariable(
                                widget.cacheKey, widget.options[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
