import 'package:eunity/classes/ReportHelper.dart';
import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:eunity/widgets/ProfileWidgets/EditImageSquare.dart';
import 'package:eunity/widgets/ProfileWidgets/NewImageSquare.dart';
import 'package:flutter/widgets.dart';

class PhotoGridItem extends StatefulWidget {
  final List imageArray;
  final int index;
  final Function onClick;
  final bool isReport;

  const PhotoGridItem(
      {super.key,
      required this.imageArray,
      required this.index,
      required this.onClick,
      required this.isReport});

  @override
  State<PhotoGridItem> createState() => _PhotoGridItemState();
}

class _PhotoGridItemState extends State<PhotoGridItem> {
  void onClick() {
    setState(() {
      widget.onClick(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: (widget.imageArray.length <= widget.index)
            ? NewImageSquare()
            : EditImageSquare(
                imageURL: (widget.isReport)
                    ? ReportHelper.getPublicReportImageURL(
                        widget.imageArray[widget.index])
                    : UserInfoHelper.getPublicImageURL(
                        widget.imageArray[widget.index])),
        onTap: onClick);
  }
}
