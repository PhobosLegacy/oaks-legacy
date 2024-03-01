import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/utils/functions.dart';

class PkmConfetti extends StatelessWidget {
  const PkmConfetti({
    super.key,
    required this.confettiController,
    required this.scaleUp,
  });

  final ConfettiController confettiController;
  final bool scaleUp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (scaleUp) ? 100 : 50,
      width: (scaleUp) ? 100 : 50,
      child: Align(
        alignment: Alignment.bottomRight,
        child: ConfettiWidget(
          confettiController: confettiController,
          blastDirectionality: BlastDirectionality
              .explosive, // don't specify a direction, blast randomly
          shouldLoop: false, // start again as soon as the animation is finished
          maximumSize: const Size(15, 15),
          minimumSize: const Size(15, 15),
          minBlastForce: 2,
          maxBlastForce: 5,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
            // Colors.red,
            // Colors.redAccent,
            // Colors.black,
            // Colors.white,
            // Colors.white70
          ], // manually specify the colors to be used
          createParticlePath: drawStar, // define a custom shape/path.
        ),
      ),
    );
  }
}
