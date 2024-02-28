import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_button.dart';
import 'package:oaks_legacy/models/tracker.dart';
import '../utils/trackers_manager.dart';

class StartTrackingButton extends StatelessWidget {
  const StartTrackingButton({
    super.key,
    required this.gamePicked,
    required this.dexPicked,
    required this.trackerPicked,
    required this.setStateCallback,
  });

  final String gamePicked;
  final String dexPicked;
  final String trackerPicked;
  final Function(Tracker) setStateCallback;

  @override
  Widget build(BuildContext context) {
    String suggestedName = '$gamePicked-$dexPicked-$trackerPicked'
        .replaceAll("Pokemon ", "")
        .replaceAll(" ", "");

    TextEditingController textController =
        TextEditingController(text: suggestedName);
    textController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: suggestedName.length,
    );
    bool isEnabled = gamePicked != "" && dexPicked != "" && trackerPicked != "";
    return PkmButton(
      buttonName: "START TRACKING!",
      onPressed: isEnabled
          ? () => {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Give a name'),
                    content: TextField(
                      autofocus: true,
                      controller: textController,
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Confirm"),
                        onPressed: () {
                          Navigator.pop(context);

                          var test = createTracker(textController.text,
                              gamePicked, dexPicked, trackerPicked);

                          setStateCallback(test);
                        },
                      ),
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              }
          : null,
      textColor: isEnabled ? Colors.white : Colors.black12,
      buttonColor: isEnabled ? Colors.amber[800] : Colors.black12,
    );
  }
}
