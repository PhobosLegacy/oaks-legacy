import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/start_tracking_button.dart';
import 'package:oaks_legacy/components/tracker_option.dart';
import 'package:oaks_legacy/components/tracker_options_title.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/tracker.dart';

class CreateTrackerButton extends StatelessWidget {
  const CreateTrackerButton({
    super.key,
    required this.onTrackerCreation,
  });

  final Function(Tracker) onTrackerCreation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showDialog(
          barrierColor: Colors.black87,
          context: context,
          builder: (BuildContext context) {
            return CreateTrackerScreen(
              onTrackerCreation: onTrackerCreation,
            );
          },
        )
      },
      child: const SizedBox(
        child: Card(
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: FittedBox(
                child: Text(
                  "CREATE TRACKER",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
                    return TrackerOption(
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
                        isPicked: (gamePicked == gamesAvailable[index]));
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
                    return TrackerOption(
                        buttonName: dexAvailable[index],
                        onPressed: (() => {
                              trackerAnimationController.forward(),
                              dexPicked = dexAvailable[index],
                              trackers = Dex.availableTrackerType(dexPicked),
                              trackerPicked = "",
                              setState(() => {}),
                            }),
                        isPicked: (dexPicked == dexAvailable[index]));
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
                  return TrackerOption(
                      buttonName: trackers[index],
                      onPressed: (() => {
                            trackerPicked = trackers[index],
                            setState(() => {}),
                          }),
                      isPicked: (trackerPicked == trackers[index]));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
