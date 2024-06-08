import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_text_dialog.dart';

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
          builder: (dialogContext) => PkmTextDialog(
            title: 'You are not logged in!',
            content:
                'Your changes will be saved locally and you can\'t access them on other devices.\n(Your browser might also erase them at any given time.)',
            onConfirm: () => {},
            isWarning: true,
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
