import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PkmFilterButton extends StatelessWidget {
  const PkmFilterButton({
    super.key,
    required this.condition,
    required this.onTap,
    required this.smallScreen,
    required this.btnContent,
    this.stretchBtn = false,
  });

  final bool condition;
  final Function()? onTap;
  final bool smallScreen;
  final Widget btnContent;
  final bool stretchBtn;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            padding: const EdgeInsets.all(5),
            height: (!stretchBtn)
                ? (smallScreen)
                    ? 50
                    : 80
                : (smallScreen)
                    ? 40
                    : 50,
            width: (!stretchBtn)
                ? (smallScreen)
                    ? 50
                    : 80
                : (smallScreen)
                    ? 120
                    : 150,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: condition ? Colors.black26 : const Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: condition ? Colors.black26 : Colors.transparent,
                ),
                boxShadow: condition
                    ? []
                    : [
                        const BoxShadow(
                          color: Colors.amber,
                          offset: Offset(5, 5),
                          blurRadius: 5,
                          spreadRadius: 0.1,
                        ),
                        BoxShadow(
                          color: Colors.blueGrey[800]!,
                          offset: const Offset(-5, -5),
                          blurRadius: 5,
                          spreadRadius: 0.1,
                        ),
                      ]),
            child: btnContent,
          ),
        ),
      ),
    );
  }
}
