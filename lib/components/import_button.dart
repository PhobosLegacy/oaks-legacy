import 'package:flutter/material.dart';
import 'package:oaks_legacy/utils/functions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ImportButton extends StatelessWidget {
  const ImportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await importFile();
      },
      child: ZoomTapAnimation(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            padding: const EdgeInsets.all(5),
            height: 50,
            width: 250,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blueGrey[800]!,
                ),
                boxShadow: const []),
            child: const Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.import_export,
                    size: 30,
                    color: Colors.amber,
                  ),
                  Text(
                    "Import",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
