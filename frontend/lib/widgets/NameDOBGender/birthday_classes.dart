import 'package:flutter/material.dart';

import 'package:eunity/classes/DesignVariables.dart';

class BoxGap extends StatelessWidget {
  final double width;
  final double height;

  const BoxGap({
    super.key,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * DesignVariables.widthConversion,
      height: height * DesignVariables.heightConversion,
    );
  }
}

class DOBSection extends StatelessWidget {
  final double width;
  final double height;
  final List<Widget> inputs;

  const DOBSection({
    super.key,
    required this.width,
    required this.height,
    required this.inputs
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height,
          width: width,
          
          decoration: BoxDecoration(
              border: Border.all(color: DesignVariables.greyLines, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: inputs,
          )
        )

      ],
    );
  }
}


class IndividualTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const IndividualTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    this.nextFocusNode,
  });

  @override
  IndividualTextFieldState createState() => IndividualTextFieldState();
}

class IndividualTextFieldState extends State<IndividualTextField> {
  late String _currentHintText;

  @override
  void initState() {
    super.initState();
    _currentHintText = widget.hintText;
    widget.focusNode.addListener(_updateHintText);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_updateHintText);
    super.dispose();
  }

  void _updateHintText() {
    setState(() {
      _currentHintText = widget.focusNode.hasFocus ? '' : widget.hintText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15,
      child: Stack(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            style: const TextStyle(fontSize: 14),
            maxLength: 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 2),
              hintText: _currentHintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              border: InputBorder.none,
            ),

            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,

            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.nextFocusNode?.requestFocus();
              } else if (value.isEmpty) {
                widget.focusNode.previousFocus();
              }
            },

          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            child: Divider(color: Colors.black.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}