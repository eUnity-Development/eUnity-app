import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';

class MatchPreferencesSlider extends StatefulWidget {
  final double initialValue;
  const MatchPreferencesSlider({super.key, required this.initialValue});

  @override
  State<MatchPreferencesSlider> createState() => _MatchPreferencesSliderState();
}

class _MatchPreferencesSliderState extends State<MatchPreferencesSlider> {
  late double sliderValue;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle minMaxLabels = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: Color.fromARGB(255, 63, 63, 63));

    const TextStyle valueIndicatorStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white);

    return Row(
      children: [
        Text(
          "1 Mi",
          style: minMaxLabels,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorTextStyle: valueIndicatorStyle,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            ),
            child: Slider(
              value: sliderValue,
              onChanged: (double newValue) {
                setState(() {
                  sliderValue = newValue;
                });
              },
              activeColor: DesignVariables.primaryRed,
              divisions: null,
              min: 1,
              max: 100,
              label: "${sliderValue.toInt()} Miles",
            ),
          ),
        ),
        Text(
          "100 Mi",
          style: minMaxLabels,
        ),
      ],
    );
  }
}
