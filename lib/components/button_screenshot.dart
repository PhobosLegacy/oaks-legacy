import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShotButton extends StatelessWidget {
  const ScreenShotButton({super.key, required this.screenshotController});

  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.camera_enhance,
        color: Colors.red,
      ),
      onPressed: () async {
        Uint8List? image;
        // try {
        image = await screenshotController.capture();
        // } catch (e) {
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text('here: $e')));
        // }
        if (image == null) return;
        final time = DateTime.now()
            .toIso8601String()
            .replaceAll('.', '-')
            .replaceAll(':', '-');

        final name = 'pk_$time';

        if (kIsWeb) {
          FileSaver.instance.saveFile(name: '$name.png', bytes: image);
        } else {
          await [Permission.storage].request();
          // final result = await ImageGallerySaver.saveImage(bytes, name: name);
          await ImageGallerySaver.saveImage(image, name: name);
        }
      },
    );
  }
}
