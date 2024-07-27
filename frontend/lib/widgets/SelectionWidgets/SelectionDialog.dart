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
  final String cacheObject;
  final bool allowNull;
  const SelectionDialog({
    super.key,
    required this.options,
    required this.question,
    required this.assetPath,
    required this.multiSelect,
    required this.cacheKey,
    required this.cacheObject,
    required this.allowNull,
  });

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
          if (UserInfoHelper.userInfoCache[widget.cacheKey] == checkedVar) {
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
            cacheValue.add(checkedVar);
          }
          return cacheValue;
        }
        return checkedVar;
      } else {
        if (widget.multiSelect) {
          List cacheValue = UserInfoHelper.userInfoCache[widget.cacheKey];
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
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white,
            border: Border.all(color: DesignVariables.greyLines, width: 2)),
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
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
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                (widget.assetPath == 'None')
                    ? SizedBox()
                    : Row(
                        children: [
                          SvgPicture.asset(
                            widget.assetPath,
                            height: 31,
                            width: 31,
                          ),
                          SizedBox(width: 5)
                        ],
                      ),
                Text(
                  widget.question,
                  style: questionSyle,
                )
              ]),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
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
                          decoration: (checkIfSelected(widget.options[index]))
                              ? selectedBox
                              : unselectedBox,
                          child: Center(
                            child: Text(
                              widget.options[index],
                              style: (checkIfSelected(widget.options[index]))
                                  ? selectedText
                                  : unselectedText,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        dynamic newValue =
                            getNewCacheValue(widget.options[index]);
                        await UserInfoHelper.updateCacheVariable(
                            widget.cacheKey, widget.cacheObject, newValue);
                        setState(() {});
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
