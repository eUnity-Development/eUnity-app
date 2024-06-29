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
  final Color borderColor;

  const DOBSection({
    super.key,
    required this.width,
    required this.height,
    required this.inputs,
    required this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          height: height,
          width: width,
          
          decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            
            children: inputs,
          )
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
  TextAlign alignment = TextAlign.center;

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
      width: 14,
      child: Center( child: Stack(
        children: [
          // TextField with 1 entry and numbers only
          TextFormField(
            //textAlignVertical: TextAlignVertical.center,
            maxLength: 1,
            textAlign: alignment,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            style: const TextStyle(fontSize: 14),
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(  
              hintText: _currentHintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              border: InputBorder.none,
              counterText: "",
            ),

            // When user types in a value, input isn't centered with TextAlign.center
            // so we use TextAlign.right to get it closer to center. Not sure why it
            // behaves like this...
            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.nextFocusNode?.requestFocus();
                alignment = TextAlign.right;

              } else if (value.isEmpty) {
                widget.focusNode.previousFocus();
                alignment = TextAlign.center;
              }
            },

          ),

          // Line underneath textfield
          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            child: Divider(color: Colors.black.withOpacity(0.5)),
          ),
        ],
      )),
    );
  }
}