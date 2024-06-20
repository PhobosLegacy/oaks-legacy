import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_drop_down.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/components/start_tracking_button.dart';
import 'package:oaks_legacy/components/tracker_options_title.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/tracker.dart';

class CreateTrackerScreen extends StatefulWidget {
  const CreateTrackerScreen({
    super.key,
    required this.onTrackerCreation,
  });

  final Function(Tracker) onTrackerCreation;

  @override
  State<CreateTrackerScreen> createState() => _CreateTrackerScreenState();
}

class _CreateTrackerScreenState extends State<CreateTrackerScreen>
    with TickerProviderStateMixin {
  String gamePicked = "";
  String dexPicked = "";
  String trackerPicked = "";
  String trackerName = "";
  List<String> gamesAvailable = Dex.availableGames();
  List<String> dexAvailable = [];
  List<String> trackers = [];
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    isMobile = PkmGrid.getCardsPerRow(context) == 1;

    return Column(
      mainAxisAlignment:
          (isMobile) ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TrackerOptionsTitle(
          title: "Create a Tracker",
        ),
        PkmDropDown(
          value: gamePicked,
          hintText: 'Select a Game',
          enableSearch: true,
          onTap: (value) {
            setState(() {
              gamePicked = value;
              dexAvailable = Dex.availableDex(gamePicked);
              dexPicked = "";
              trackerPicked = "";
              trackers.clear();
            });
          },
          items: gamesAvailable
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              height: (isMobile) ? 50 : 70,
                              '$kImageLocalPrefix${Game.gameIcon(item)}'),
                        ),
                        AutoSizeText(
                          item,
                          style: TextStyle(
                            fontSize: (isMobile) ? 15 : 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
        PkmDropDown(
          value: dexPicked,
          hintText: 'Select a dex',
          onTap: (dex) {
            setState(() {
              dexPicked = dex;
              trackers = Dex.availableTrackerType(dexPicked);
              trackerPicked = "";
            });
          },
          items: dexAvailable
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Center(
                      child: AutoSizeText(
                        item,
                        style: TextStyle(
                          fontSize: (isMobile) ? 15 : 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        PkmDropDown(
          value: trackerPicked,
          hintText: 'Select a tracker',
          onTap: (tracker) {
            setState(() {
              trackerPicked = tracker;
              setState(() => {});
            });
          },
          items: trackers
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Center(
                      child: AutoSizeText(
                        item,
                        style: TextStyle(
                          fontSize: (isMobile) ? 15 : 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: StartTrackingButton(
                dexPicked: dexPicked,
                gamePicked: gamePicked,
                trackerPicked: trackerPicked,
                setStateCallback: widget.onTrackerCreation,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
