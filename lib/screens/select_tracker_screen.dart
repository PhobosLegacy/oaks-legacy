import 'package:flutter/material.dart';
import 'package:proto_dex/components/app_bar.dart';
import 'package:proto_dex/components/base_background.dart';
import 'package:proto_dex/components/start_tracking_button.dart';
import 'package:proto_dex/components/tracker_option.dart';
import 'package:proto_dex/components/tracker_options_title.dart';
import '../models/tracker.dart';
import '../models/game.dart';
import '../tracker/tracker_list_screen.dart';
import '../utils/trackers_manager.dart';

class SelectTrackerScreen extends StatefulWidget {
  const SelectTrackerScreen({super.key});

  @override
  State<SelectTrackerScreen> createState() => _SelectTrackerScreenState();
}

class _SelectTrackerScreenState extends State<SelectTrackerScreen> {
  String gamePicked = "";
  String dexPicked = "";
  String trackerPicked = "";
  String trackerName = "";
  List<String> gamesAvailable = Dex.availableGames();
  List<String> dexAvailable = [];
  List<String> trackers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarBase(
        title: const Text("Select Tracker"),
        color: Colors.blueGrey[800],
        actions: null,
      ),
      body: Stack(
        children: [
          const BaseBackground(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      gameList(),
                      dexList(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      trackersList(),
                      recentList(),
                    ],
                  ),
                ),
                StartTrackingButton(
                  dexPicked: dexPicked,
                  gamePicked: gamePicked,
                  trackerPicked: trackerPicked,
                  setStateCallback: () => setState(() {}),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded gameList() {
    return Expanded(
      child: Column(
        children: [
          const TrackerOptionsTitle(
            title: "GAMES",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gamesAvailable.length,
              itemBuilder: (BuildContext context, int index) {
                return TrackerOption(
                    buttonName: gamesAvailable[index],
                    imagePath: Game.gameIcon(gamesAvailable[index]),
                    onPressed: (() => {
                          setState(() {
                            gamePicked = gamesAvailable[index];
                            dexAvailable = Dex.availableDex(gamePicked);
                            dexPicked = "";
                            trackerPicked = "";
                            trackers = Dex.availableTrackerType('');
                          })
                        }),
                    isPicked: (gamePicked == gamesAvailable[index]));
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded dexList() {
    return Expanded(
        child: Column(
      children: [
        const TrackerOptionsTitle(
          title: "DEX",
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dexAvailable.length,
            itemBuilder: (context, index) {
              return TrackerOption(
                  buttonName: dexAvailable[index],
                  onPressed: (() => {
                        setState(() {
                          dexPicked = dexAvailable[index];
                          trackers = Dex.availableTrackerType(dexPicked);
                          trackerPicked = "";
                        })
                      }),
                  isPicked: (dexPicked == dexAvailable[index]));
            },
          ),
        ),
      ],
    ));
  }

  Expanded trackersList() {
    return Expanded(
      child: Column(
        children: [
          const TrackerOptionsTitle(
            title: "TRACKERS",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: trackers.length,
              itemBuilder: (context, index) {
                return TrackerOption(
                    buttonName: trackers[index],
                    onPressed: (() => {
                          setState(() {
                            trackerPicked = trackers[index];
                          })
                        }),
                    isPicked: (trackerPicked == trackers[index]));
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded recentList() {
    return Expanded(
      child: Column(
        children: [
          const TrackerOptionsTitle(
            title: "RECENT",
          ),
          Expanded(
            child: FutureBuilder<List<Tracker>>(
              future: getAllTrackers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No trackers available."));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => TrackerOption(
                      buttonName: snapshot.data![index].name,
                      onLongPress: () =>
                          showDeleteDialog(snapshot.data![index], context),
                      onPressed: () => navigateToTrackerListScreen(
                          snapshot.data![index], context),
                      isPicked: false,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(Tracker tracker, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Tracker'),
        content: Text('Remove ${tracker.name}?'),
        actions: [
          TextButton(
            child: const Text("Confirm"),
            onPressed: () {
              setState(() {
                deleteTracker(tracker.ref);
                Navigator.pop(context);
              });
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void navigateToTrackerListScreen(Tracker tracker, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrackerListScreen(
          collection: getTracker(tracker.ref),
        ),
      ),
    );
  }
}
