import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionDialogEnterText.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionDialogHeight.dart';
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
  final bool? isListLong;
  final String cacheObject;
  final bool allowNull;
  const SelectionDialog({
    super.key,
    required this.options,
    required this.question,
    required this.assetPath,
    required this.multiSelect,
    required this.cacheKey,
    this.isListLong,
    required this.cacheObject,
    required this.allowNull,
  });

  @override
  State<SelectionDialog> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  int maxInterests = 7;

  @override
  Widget build(BuildContext context) {
    const TextStyle questionStyle = TextStyle(
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

    TextStyle unselectedText = const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);

    bool isLongList = widget.isListLong ?? false;

    double maxHeight = MediaQuery.of(context).size.height -
        (40 * DesignVariables.heightConversion);
    double minHeight = 400;
    double height = (isLongList ? 32.0 : 80.0) * widget.options.length;

    // job requires user input, so make room for keyboard
    if (widget.cacheKey == 'job') {
      height = maxHeight / 1.25;
    }

    if (widget.question.length > 25) {
      height += 100.0;
    }

    if (height < minHeight) {
      height = minHeight;
    } else if (height > maxHeight) {
      height = maxHeight;
    }

    int maxInterests = 7;

    bool checkIfSelected(var checkedVar) {
      if (widget.cacheObject != '') {
        if (widget.multiSelect) {
          if (UserInfoHelper.userInfoCache[widget.cacheObject][widget.cacheKey]
              .contains(checkedVar)) {
            return true;
          }
        } else {
          if (UserInfoHelper.userInfoCache[widget.cacheObject]
                  [widget.cacheKey] ==
              checkedVar) {
            return true;
          }
        }
      } else {
        if (widget.multiSelect) {
          if (UserInfoHelper.userInfoCache[widget.cacheKey]
              .contains(checkedVar)) {
            return true;
          }
        } else {
          if (widget.cacheKey == 'userGenderOptions' &&
            UserInfoHelper.tempCache['userGender'] == checkedVar) { 
              return true;
          }
          if (UserInfoHelper.userInfoCache
                  [widget.cacheKey] ==
              checkedVar) {
            return true;
          }
        }
      }
      return false;
    }

    dynamic getNewCacheValue(var checkedVar) {
      if (widget.cacheObject != '') {
        if (widget.multiSelect) {
          List cacheValue =
              UserInfoHelper.userInfoCache[widget.cacheObject][widget.cacheKey];
          if (cacheValue.contains(checkedVar)) {
            if (cacheValue.length != 1) {
              cacheValue.remove(checkedVar);
            }
          } else {
            if (widget.cacheKey != 'interests' ||
                (widget.cacheKey == 'interests' &&
                    cacheValue.length < maxInterests)) {
              cacheValue.add(checkedVar);
            }
          }
          return cacheValue;
        }
        return checkedVar;
      } else {
        if (widget.multiSelect) {
          List cacheValue =
              UserInfoHelper.userInfoCache[widget.cacheKey];
          if (cacheValue.contains(checkedVar)) {
            cacheValue.remove(checkedVar);
          } else {
            cacheValue.add(checkedVar);
          }
          return cacheValue;
        }
        return checkedVar;
      }
    }

    return Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white,
            border: Border.all(color: DesignVariables.greyLines, width: 2)),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: SvgPicture.asset(
                    "assets/MiscIcons/icon-heavy-x.svg",
                    height: 38,
                    width: 38,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      if (widget.assetPath != 'None') ...[
                        WidgetSpan(
                          child: Transform.translate(
                            // manually center the svg
                            offset: Offset(
                                0, (questionStyle.fontSize ?? 24) * 0.16),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: SvgPicture.asset(
                                widget.assetPath,
                                height: 31,
                                width: 31,
                              ),
                            ),
                          ),
                        ),
                      ],
                      TextSpan(
                        text: widget.question,
                        style: questionStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height - 150,
                width: double.infinity,
                child: (widget.cacheKey == 'job')
                    ? SelectionDialogEnterText(
                        cacheKey: widget.cacheKey,
                        cacheObject: widget.cacheObject,
                        labelString: 'Job Title (Optional)',
                      )
                    : (widget.cacheKey == 'height')
                        ? SelectionDialogHeight(
                            exitFunction: () => Navigator.pop(context),
                            cacheKey: widget.cacheKey,
                          )
                        : Wrap(
                            spacing: 6.0,
                            alignment: WrapAlignment.center,
                            children: List<Widget>.generate(
                                widget.options.length, (index) {
                              return GestureDetector(
                                child: (!isLongList)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 40, right: 40),
                                        child: Container(
                                          width: double.infinity,
                                          height: 42,
                                          decoration: (checkIfSelected(
                                                  widget.options[index]))
                                              ? selectedBox
                                              : unselectedBox,
                                          child: Center(
                                            child: Text(
                                              widget.options[index],
                                              style: (checkIfSelected(
                                                      widget.options[index]))
                                                  ? selectedText
                                                  : unselectedText,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 1.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Container(
                                              decoration: (checkIfSelected(
                                                      widget.options[index]))
                                                  ? selectedBox
                                                  : unselectedBox,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 3.5),
                                              child: Text(
                                                widget.options[index],
                                                style: (checkIfSelected(
                                                        widget.options[index]))
                                                    ? selectedText
                                                    : unselectedText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                onTap: () async {
                                  dynamic newValue =
                                      getNewCacheValue(widget.options[index]);
                                  await UserInfoHelper.updateCacheVariable(
                                      widget.cacheKey,
                                      widget.cacheObject,
                                      newValue);
                                  setState(() {});
                                },
                              );
                            }),
                          ),
              ),
            ],
          ),
        ));
  }
}
