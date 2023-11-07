import 'package:flutter/material.dart';
import 'package:proto_dex/components/app_bar.dart';
import 'package:proto_dex/components/base_background.dart';
import 'package:proto_dex/components/image.dart';
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
  @override
  void initState() {
    super.initState();
  }

  String gamePicked = "";
  String dexPicked = "";
  String trackerPicked = "";
  String trackerName = "";
  List<String> gamesAvailable = Dex.availableGames();
  List<String> dexAvailable = [];
  // List<String> trackers = Dex.availableTrackerTypes();
  List<String> trackers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarBase(
        title: const Text("Trackers"),
        color: Colors.blueGrey[800],
        actions: null,
      ),
      body: Stack(
        children: <Widget>[
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
                Row(
                  children: [
                    startTrackingButton(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded startTrackingButton(BuildContext context) {
    String suggestedName = '$gamePicked-$dexPicked-$trackerPicked'
        .replaceAll("Pokemon ", "")
        .replaceAll(" ", "");

    TextEditingController textController =
        TextEditingController(text: suggestedName);
    textController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: suggestedName.length,
    );
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey[800],
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.blueGrey[900],
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
                              onChanged: (value) {
                                trackerName = textController.text;
                              },
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Confirm"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {});
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
    );
  }

  Expanded gameList() {
    return Expanded(
      child: Column(
        children: [
          const TrackerScreenTitles(
            title: "GAMES",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gamesAvailable.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: TrackerButton(
                      buttonName: gamesAvailable[index],
                      imagePath: Game.gameIcon(gamesAvailable[index]),
                      onPressed: (() => {
                            setState(() {
                              gamePicked = gamesAvailable[index];
                              dexAvailable = Dex.availableDex(gamePicked);
                              dexPicked = "";
                              trackers = Dex.availableTrackerType('');
                            })
                          }),
                      isPicked: (gamePicked == gamesAvailable[index])),
                );
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
        const TrackerScreenTitles(
          title: "DEX",
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dexAvailable.length,
            itemBuilder: (BuildContext context, int index2) {
              return Padding(
                padding: const EdgeInsets.all(2.5),
                child: TrackerButton(
                    buttonName: dexAvailable[index2],
                    imagePath: '',
                    onPressed: (() => {
                          setState(() {
                            dexPicked = dexAvailable[index2];
                            trackers = Dex.availableTrackerType(dexPicked);
                          })
                        }),
                    isPicked: (dexPicked == dexAvailable[index2])),
              );
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
          const TrackerScreenTitles(
            title: "TRACKERS",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: trackers.length,
              itemBuilder: (BuildContext context, int index3) {
                return Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: TrackerButton(
                      buttonName: trackers[index3],
                      imagePath: '',
                      onPressed: (() => {
                            setState(() {
                              trackerPicked = trackers[index3];
                            })
                          }),
                      isPicked: (trackerPicked == trackers[index3])),
                );
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
          const TrackerScreenTitles(
            title: "RECENT",
          ),
          Expanded(
            child: FutureBuilder(
              future: getAllTrackers(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Tracker>> snapshot) {
                if (snapshot.hasData) {
                  snapshot.data!.toList().forEach((element) {
                    // if (!recentTrackers.contains(element.name)) {
                    //   recentTrackers.add(element.name);
                    // }
                  });
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: TrackerButton(
                            buttonName: snapshot.data![index].name,
                            imagePath: '',
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Delete Tracker'),
                                  content: Text(
                                      'Remove ${snapshot.data![index].name}?'),
                                  actions: [
                                    TextButton(
                                      child: const Text("Confirm"),
                                      onPressed: () {
                                        deleteTracker(
                                          snapshot.data![index].ref,
                                        );
                                        Navigator.pop(context);
                                        setState(() {});
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
                              );
                            },
                            onPressed: (() => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TrackerListScreen(
                                            collection: getTracker(
                                                snapshot.data![index].ref));
                                      },
                                    ),
                                  ),
                                }),
                            isPicked: false),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TrackerScreenTitles extends StatelessWidget {
  const TrackerScreenTitles({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}

class TrackerButton extends StatelessWidget {
  const TrackerButton({
    super.key,
    required this.buttonName,
    required this.imagePath,
    required this.onPressed,
    required this.isPicked,
    this.onLongPress,
  });

  final String buttonName;
  final String imagePath;
  final Function()? onPressed;
  final Function()? onLongPress;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    Color color = (isPicked) ? Colors.blue : Colors.grey;
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: 30,
        child: TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (imagePath != "")
                ListImage(image: imagePath), //Image.asset(imagePath, scale: 2),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    buttonName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
