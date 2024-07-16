import 'package:eunity/widgets/ImageWidgets/PhotoGridOption.dart';
import 'package:flutter/widgets.dart';

class ImageGrid extends StatefulWidget {
  final List imageArray;
  final Function onItemClick;
  final Function onReorder;
  const ImageGrid(
      {super.key,
      required this.imageArray,
      required this.onItemClick,
      required this.onReorder});

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10, // Horizontal spacing between grid items
        mainAxisSpacing: 10, // Vertical spacing between grid items
      ),
      physics: NeverScrollableScrollPhysics(),
      itemCount: 9, // Total number of items (3x3 grid)
      itemBuilder: (context, index) {
        return PhotoGridOption(
            imageArray: widget.imageArray,
            index: index,
            onItemClick: widget.onItemClick,
            onReorder: widget.onReorder);
      },
    );
  }
}
