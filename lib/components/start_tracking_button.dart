import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_text_dialog.dart';
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
                  builder: (_) => PkmTextEditDialog(
                      title: 'Tracker Name',
                      textController: textController,
                      onChange: () async {
                        var test = await createTracker(textController.text,
                            gamePicked, dexPicked, trackerPicked);

                        setStateCallback(test);
                      }),
                ),
              }
          : null,
      textColor: isEnabled ? Colors.white : Colors.black12,
      buttonColor: isEnabled ? Colors.amber[800] : Colors.black12,
    );
  }
}
