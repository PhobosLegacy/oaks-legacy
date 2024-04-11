import 'package:flutter/material.dart';
import 'package:oaks_legacy/utils/functions.dart';

class PkmButton extends StatefulWidget {
  const PkmButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.textColor,
    required this.buttonColor,
    this.imagePath = '',
    this.onLongPress,
    this.auxWidget,
  });

  final String buttonName;
  final String imagePath;
  final Color? textColor;
  final Color? buttonColor;
  final Function()? onPressed;
  final Function()? onLongPress;
  final Widget? auxWidget;

  @override
  State<PkmButton> createState() => _PkmButtonState();
}

class _PkmButtonState extends State<PkmButton> with TickerProviderStateMixin {
  bool isHovered = false;

  void onEntered(isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }

  Color makeItDarker(Color color, double percent) {
    // Ensure the percentage is between 0 and 1
    percent = percent.clamp(0.0, 1.0);

    // Calculate darker values for each channel
    int red = (color.red * (1 - percent)).round();
    int green = (color.green * (1 - percent)).round();
    int blue = (color.blue * (1 - percent)).round();

    // Create a new Color with the darker values
    return Color.fromARGB(color.alpha, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    double width = getButtonWidth(
            MediaQuery.of(context).size.width, [600, 600, 600, 700]) /
        2;
    double height =
        width * ((MediaQuery.of(context).size.height > 1000) ? 0.35 : 0.18);

    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        onLongPress: widget.onLongPress,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width,
            maxHeight: height,
          ),
          child: Transform.scale(
            scale: isHovered ? 1.02 : 1.0,
            child: Card(
              color: isHovered
                  ? makeItDarker(widget.buttonColor!, 0.1)
                  : widget.buttonColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
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
                    if (widget.auxWidget != null) widget.auxWidget!,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
