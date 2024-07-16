import 'package:eunity/classes/DesignVariables.dart';
import 'package:eunity/widgets/ImageWidgets/PhotoGridItem.dart';
import 'package:flutter/widgets.dart';

class PhotoGridOption extends StatefulWidget {
  final int index;
  final List imageArray;
  final Function onItemClick;
  final Function onReorder;
  const PhotoGridOption(
      {super.key,
      required this.index,
      required this.imageArray,
      required this.onItemClick,
      required this.onReorder});

  @override
  State<PhotoGridOption> createState() => _PhotoGridOptionState();
}

class _PhotoGridOptionState extends State<PhotoGridOption> {
  @override
  Widget build(BuildContext context) {
    return (widget.index >= widget.imageArray.length)
        ? PhotoGridItem(
            imageArray: widget.imageArray,
            index: widget.index,
            onClick: widget.onItemClick,
            isReport: false,
          )
        : LongPressDraggable<int>(
            data: widget.index,
            feedback: PhotoGridItem(
              imageArray: widget.imageArray,
              index: widget.index,
              onClick: widget.onItemClick,
              isReport: false,
            ),
            childWhenDragging: Container(
              decoration: BoxDecoration(
                  color: DesignVariables.greyLines,
                  borderRadius: BorderRadius.circular(
                      21 * DesignVariables.heightConversion)),
            ),
            child: DragTarget<int>(
              builder: (BuildContext context, List<int?> candidateData,
                  List<dynamic> rejectedData) {
                return PhotoGridItem(
                  imageArray: widget.imageArray,
                  index: widget.index,
                  onClick: widget.onItemClick,
                  isReport: false,
                );
              },
              onAccept: (int fromIndex) async {
                await widget.onReorder(fromIndex, widget.index);
              },
            ),
          );
  }
}
