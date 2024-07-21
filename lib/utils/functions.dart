import 'dart:convert';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';

double getButtonWidth(double width, List<double> widths) {
  for (int i = 0; i < kBreakpoints.length; i++) {
    if (width < kBreakpoints[i]) {
      return widths[i];
    }
  }

  return widths.last;
}

/// A custom Path to paint stars to be used in the Confetti animation
Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3), // Adjust duration as needed
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Some code to execute when the action button is pressed
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Color makeItDarker(Color color, double percent) {
  // Ensure the percentage is between 0 and 1
  percent = percent.clamp(0.0, 1.0);

  // Calculate darker values for each channel
  int red = (color.red * (1 - percent)).round();
  int green = (color.green * (1 - percent)).round();
  int blue = (color.blue * (1 - percent)).round();

  // Create a new Color with the darker values
  return Color.fromARGB(color.alpha, red, green, blue);
}

Future<void> exportFile(String fileName, String content) async {
  // Convert the JSON data to a Uint8List
  Uint8List fileBytes = Uint8List.fromList(utf8.encode(content));

  if (kIsWeb) {
    // Use FileSaver for web
    await FileSaver.instance.saveFile(
      name: '$fileName.oak',
      bytes: fileBytes,
      mimeType: MimeType.json,
    );
  }
}

Future<String> importFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['oak'],
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    if (file.bytes != null) {
      Uint8List fileBytes = file.bytes!;
      String jsonString = utf8.decode(fileBytes);
      return jsonString;
    }
  }
  return '';
}
