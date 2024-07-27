import 'package:eunity/classes/UserInfoHelper.dart';
import 'package:flutter/material.dart';
import 'package:eunity/classes/DesignVariables.dart';

class MatchPreferencesRangeSlider extends StatefulWidget {
  final double initialMinimum;
  final double initialMaximum;
  const MatchPreferencesRangeSlider(
      {super.key, required this.initialMinimum, required this.initialMaximum});

  @override
  State<MatchPreferencesRangeSlider> createState() =>
      _MatchPreferencesRangeSliderState();
}

class _MatchPreferencesRangeSliderState
    extends State<MatchPreferencesRangeSlider> {
  late double sliderMinimum;
  late double sliderMaximum;

  @override
  void initState() {
    super.initState();
    sliderMinimum = widget.initialMinimum;
    sliderMaximum = widget.initialMaximum;
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
          "18",
          style: minMaxLabels,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorTextStyle: valueIndicatorStyle,
              rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
            ),
            child: RangeSlider(
              values: RangeValues(sliderMinimum, sliderMaximum),
              onChanged: (RangeValues newValues) async {
                Map<dynamic, dynamic> matchPreferences =
                    UserInfoHelper.userInfoCache['match_preferences'];
                matchPreferences['maximum_age'] = newValues.end.toInt();
                matchPreferences['minimum_age'] = newValues.start.toInt();
                await UserInfoHelper.updateCacheVariable(
                    'match_preferences', '', matchPreferences);
                setState(() {
                  sliderMinimum = newValues.start;
                  sliderMaximum = newValues.end;
                });
              },
              activeColor: DesignVariables.primaryRed,
              divisions: null,
              min: 18,
              max: 65,
              labels: RangeLabels(
                  "${sliderMinimum.toInt()}", "${sliderMaximum.toInt()}"),
            ),
          ),
        ),
        Text(
          "65+",
          style: minMaxLabels,
        ),
      ],
    );
  }
}
