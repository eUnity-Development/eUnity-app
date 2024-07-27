import 'package:flutter/material.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionDialog.dart';

// Allows selection pop-up to work on any button
void showSelectDialog({
  required BuildContext context,
  required List<String> options,
  required String question,
  required String assetPath,
  required String cacheKey,
  required String cacheObject,
  required bool multiSelect,
  required bool allowNull,
  required reRender,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return SelectionDialog(
        options: options,
        question: question,
        assetPath: assetPath,
        cacheKey: cacheKey,
        cacheObject: cacheObject,
        multiSelect: multiSelect,
        allowNull: allowNull,
      );
    },
  ).then((value) {
    reRender();
  });
}
