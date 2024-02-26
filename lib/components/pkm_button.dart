import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';

class PkmButton extends StatefulWidget {
  const PkmButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.textColor,
    required this.buttonColor,
    this.imagePath = '',
    this.onLongPress,
  });

  final String buttonName;
  final String imagePath;
  final Color? textColor;
  final Color? buttonColor;
  final Function()? onPressed;
  final Function()? onLongPress;

  @override
  State<PkmButton> createState() => _PkmButtonState();
}

class _PkmButtonState extends State<PkmButton> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = getButtonWidth(MediaQuery.of(context).size.width) / 2;
    double height =
        width * ((MediaQuery.of(context).size.height > 1000) ? 0.35 : 0.18);

    return GestureDetector(
      onTap: widget.onPressed,
      onLongPress: widget.onLongPress,
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          color: widget.buttonColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.imagePath != "")
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image.network(
                      widget.imagePath,
                    ),
                  ),
                Flexible(
                  child: Center(
                    child: Text(
                      widget.buttonName,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: height * 0.20,
                        color: widget.textColor,
                      ),
                      maxLines: 2,
                    ),
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
