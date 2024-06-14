import 'package:flutter/material.dart';


class MatchModel {
  final String avatarPath;
  final String name;

  MatchModel({
    required this.avatarPath,
    required this.name,
  });
}
class MatchTile extends StatelessWidget {
  final MatchModel match;

  MatchTile({required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,  // Increased width
          height: 90,  // Increased height
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 2),
          ),
          child: ClipOval(
            child: Image.asset(
              match.avatarPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(match.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}