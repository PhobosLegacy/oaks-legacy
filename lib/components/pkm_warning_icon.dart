import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class PkmWarningIcon extends StatelessWidget {
  const PkmWarningIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            backgroundColor: const Color(0xFF1D1E33),
            title: const Text(
              'You are not logged in.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.amber),
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your changes will be saved locally and you can\'t access them on other devices.',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '(Your browser might also erase them at any given time.)',
                  style: TextStyle(
                      color: Colors.white, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  child: const Icon(Icons.check, color: Colors.green),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                ),
              ),
            ],
          ),
        );
      },
      icon: AvatarGlow(
        glowColor: Colors.amberAccent,
        glowRadiusFactor: 1,
        child: const Icon(
          Icons.warning,
          color: Colors.yellow,
          size: 30,
        ),
      ),
    );
  }
}
