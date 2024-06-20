import 'package:flutter/material.dart';

class TrackerOptionsTitle extends StatelessWidget {
  const TrackerOptionsTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        child: Text(
          title,
          textScaler: const TextScaler.linear(1.5),
        ),
      ),
    );
  }
}
