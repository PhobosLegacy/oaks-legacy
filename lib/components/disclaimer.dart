import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DisclaimerText(
            text:
                "Pokémon and its trademarks are ©1995-2023 Nintendo,  Creatures, and GAMEFREAK.",
          ),
          Divider(height: 6),
          DisclaimerText(
            text:
                "All images and names owned and trademarked by Nintendo, The Pokémon Company, and GAMEFREAK are property of their respective owners.",
          ),
          Divider(height: 6),
          DisclaimerText(
            text:
                "This website is not officially affiliated with Pokémon and is intended to fall under Fair Use doctrine, similar to any other informational site such as a wiki.",
          ),
          Divider(height: 6),
        ],
      ),
    );
  }
}

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            color: Colors.amber.shade200,
            backgroundColor: Colors.black26,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }
}
