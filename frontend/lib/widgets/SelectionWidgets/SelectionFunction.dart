import 'package:flutter/material.dart';
import 'package:eunity/widgets/SelectionWidgets/SelectionDialog.dart';

// Allows selection pop-up to work on any button
void showSelectDialog({
  required BuildContext context,
  required List<String> options,
  required String question,
  required String assetPath,
  required String cacheKey,
  required bool multiSelect,
  required reRender,
  bool? isListLong
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return SelectionDialog(
        options: options,
        question: question,
        assetPath: assetPath,
        cacheKey: cacheKey,
        multiSelect: multiSelect,
        isListLong: isListLong,
      );
    },
  ).then((value) {
    reRender();
  });
}
