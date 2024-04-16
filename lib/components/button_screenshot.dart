import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as img;

class ScreenShotButton extends StatelessWidget {
  const ScreenShotButton({super.key, required this.screenshotController});

  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.camera_enhance,
        color: Colors.white,
      ),
      onPressed: () async {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  "Hang On...",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            );
          },
        );

        Uint8List? imageBytes;

        imageBytes = await screenshotController.capture();

        if (imageBytes == null) return;

        //Trimmer
        img.Image originalImage = img.decodeImage(imageBytes)!;
        img.Image trimmedImage = img.trim(originalImage);
        Uint8List trimmedImageBytes =
            Uint8List.fromList(img.encodePng(trimmedImage));
        //END

        final time = DateTime.now()
            .toIso8601String()
            .replaceAll('.', '-')
            .replaceAll(':', '-');

        final name = 'pk_$time';

        if (kIsWeb) {
          FileSaver.instance
              .saveFile(name: '$name.png', bytes: trimmedImageBytes);
        } else {
          await [Permission.storage].request();
          await ImageGallerySaver.saveImage(trimmedImageBytes, name: name);
        }
        if (context.mounted) Navigator.pop(context); // Close the loading modal
      },
    );
  }
}
