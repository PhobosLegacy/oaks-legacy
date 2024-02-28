import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_button.dart';
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

  late AnimationController dexAnimationController;
  late Animation dexAnimation;

  late AnimationController trackerAnimationController;
  late Animation trackerAnimation;

  @override
  void initState() {
    super.initState();
    dexAnimationController = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    dexAnimation = IntTween(begin: 0, end: 200).animate(dexAnimationController);
    dexAnimation.addListener(() => setState(() {}));

    trackerAnimationController = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    trackerAnimation =
        IntTween(begin: 0, end: 500).animate(trackerAnimationController);
    trackerAnimation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TrackerOptionsTitle(
          title: "Create a Tracker",
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Visibility(
                        visible: true,
                        // visible: (trackerAnimation.value > 0) ? false : true,
                        child: gameList(100)),
                    Visibility(
                        visible: (dexAnimation.value > 0) ? true : false,
                        child: dexList(dexAnimation.value)),
                    Visibility(
                        visible: (trackerAnimation.value > 0) ? true : false,
                        child: trackersList(trackerAnimation.value)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StartTrackingButton(
                      dexPicked: dexPicked,
                      gamePicked: gamePicked,
                      trackerPicked: trackerPicked,
                      setStateCallback: widget.onTrackerCreation,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget gameList(flex) {
    return Expanded(
      flex: 200,
      child: Column(
        children: [
          const TrackerOptionsTitle(
            title: "GAME",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 1.0,
                runSpacing: 1.0,
                children: List.generate(
                  gamesAvailable.length,
                  (index) {
                    return PkmButton(
                        buttonName: gamesAvailable[index],
                        imagePath:
                            '$kImageLocalPrefix${Game.gameIcon(gamesAvailable[index])}',
                        onPressed: () => {
                              setState(() => {
                                    dexAnimationController.forward(),
                                    gamePicked = gamesAvailable[index],
                                    dexAvailable = Dex.availableDex(gamePicked),
                                    dexPicked = "",
                                    trackerPicked = "",
                                    trackers = Dex.availableTrackerType(''),
                                  }),
                            },
                        textColor: Colors.black,
                        buttonColor: (gamePicked == gamesAvailable[index])
                            ? Colors.blue
                            : Colors.grey);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dexList(flex) {
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          const TrackerOptionsTitle(
            title: "DEX",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 1.0,
                runSpacing: 1.0,
                children: List.generate(
                  dexAvailable.length,
                  (index) {
                    return PkmButton(
                        buttonName: dexAvailable[index],
                        onPressed: (() => {
                              trackerAnimationController.forward(),
                              dexPicked = dexAvailable[index],
                              trackers = Dex.availableTrackerType(dexPicked),
                              trackerPicked = "",
                              setState(() => {}),
                            }),
                        textColor: Colors.black,
                        buttonColor: (dexPicked == dexAvailable[index])
                            ? Colors.blue
                            : Colors.grey);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget trackersList(flex) {
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          const TrackerOptionsTitle(
            title: "TRACKERS",
          ),
          SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 1.0,
              runSpacing: 1.0,
              children: List.generate(
                trackers.length,
                (index) {
                  return PkmButton(
                      buttonName: trackers[index],
                      onPressed: (() => {
                            trackerPicked = trackers[index],
                            setState(() => {}),
                          }),
                      textColor: Colors.black,
                      buttonColor: (trackerPicked == trackers[index])
                          ? Colors.blue
                          : Colors.grey);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
