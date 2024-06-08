import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onPress,
    required this.icon,
  });

  final Function()? onPress;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    double boxSize = (MediaQuery.of(context).size.width < 1024)
        ? MediaQuery.of(context).size.width / 10
        : 60;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (onPress == null)
            ? Container()
            : SizedBox(
                width: boxSize,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.white12),
                    ),
                  ),
                  onPressed: onPress,
                  child: icon,
                ),
              ),
      ),
    );
  }
}
