import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/image.dart';

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
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: SizedBox(
          height: 30,
          child: TextButton(
            onPressed: onPressed,
            onLongPress: onLongPress,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (imagePath != "")
                  TrackerIcon(
                      image: imagePath), //Image.asset(imagePath, scale: 2),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      buttonName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: color),
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
}
