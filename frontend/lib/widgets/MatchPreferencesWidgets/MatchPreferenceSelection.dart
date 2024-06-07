import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';

class MatchPreferenceSelection extends StatefulWidget {
  final String label;
  const MatchPreferenceSelection({super.key, required this.label});

  @override
  State<MatchPreferenceSelection> createState() =>
      _MatchPreferenceSelectionState();
}

class _MatchPreferenceSelectionState extends State<MatchPreferenceSelection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
          border: Border.all(color: DesignVariables.greyLines, width: 1),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color.fromARGB(128, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
