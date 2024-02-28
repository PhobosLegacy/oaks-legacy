import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/utils/functions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.percentage,
  });

  final double percentage;

  @override
  Widget build(BuildContext context) {
    double width = getButtonWidth(
            MediaQuery.of(context).size.width, [600, 600, 600, 700]) /
        2;
    double height =
        width * ((MediaQuery.of(context).size.height > 1000) ? 0.35 : 0.18);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: LinearPercentIndicator(
          animation: true,
          lineHeight: height * 0.2,
          animationDuration: 1000,
          percent: percentage / 100,
          center: Text(
            '$percentage%',
            style: TextStyle(fontSize: height * 0.18),
          ),
          barRadius: const Radius.circular(16),
          progressColor: Colors.green,
        ),
      ),
    );
  }
}
