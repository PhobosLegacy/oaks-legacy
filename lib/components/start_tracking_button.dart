import 'package:flutter/material.dart';
import '../tracker/tracker_list_screen.dart';
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
  final VoidCallback setStateCallback;

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
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey[800],
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.blueGrey[700],
                disabledForegroundColor: Colors.blueGrey[900],
              ),
              onPressed:
                  (gamePicked != "" && dexPicked != "" && trackerPicked != "")
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
                                      setStateCallback();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return TrackerListScreen(
                                                collection: createTracker(
                                                    textController.text,
                                                    gamePicked,
                                                    dexPicked,
                                                    trackerPicked));
                                          },
                                        ),
                                      );
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
              child: const Text("START TRACKING!"),
            ),
          ),
        ),
      ],
    );
  }
}
