import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TrackerOption extends StatelessWidget {
  const TrackerOption({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.isPicked,
    this.imagePath = '',
    this.onLongPress,
  });

  final String buttonName;
  final String imagePath;
  final Function()? onPressed;
  final Function()? onLongPress;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    Color color = (isPicked) ? Colors.blue : Colors.grey;
    double width = getButtonWidth(MediaQuery.of(context).size.width) / 2;
    double height =
        width * ((MediaQuery.of(context).size.height > 1000) ? 0.35 : 0.18);

    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (imagePath != "")
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image.network(
                      imagePath,
                    ),
                  ),
                Flexible(
                  child: Text(
                    buttonName,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, fontSize: height * 0.20),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getButtonWidth(double width) {
    List<double> widths = [600, 600, 600, 700];

    for (int i = 0; i < kBreakpoints.length; i++) {
      if (width < kBreakpoints[i]) {
        return widths[i];
      }
    }

    return widths.last;
  }
}

class TrackerItem extends StatelessWidget {
  const TrackerItem({
    super.key,
    required this.name,
    required this.onPressed,
    required this.percentageCompleted,
    this.imagePath = '',
    this.onLongPress,
  });

  final String name;
  final String imagePath;
  final String percentageCompleted;
  final Function()? onPressed;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    double width = getButtonWidth(MediaQuery.of(context).size.width) / 2;
    double height =
        width * ((MediaQuery.of(context).size.height > 1000) ? 0.35 : 0.18);

    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (imagePath != "")
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.network(
                          imagePath,
                        ),
                      ),
                    Flexible(
                      child: Text(
                        name,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: height * 0.20),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 1000,
                    percent: double.parse(percentageCompleted) / 100,
                    center: Text('$percentageCompleted%'),
                    barRadius: const Radius.circular(16),
                    progressColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getButtonWidth(double width) {
    List<double> widths = [600, 600, 600, 700];

    for (int i = 0; i < kBreakpoints.length; i++) {
      if (width < kBreakpoints[i]) {
        return widths[i];
      }
    }

    return widths.last;
  }
}
