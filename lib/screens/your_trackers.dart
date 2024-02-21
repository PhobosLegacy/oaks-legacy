import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/app_bar.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/tracker_option.dart';
import 'package:oaks_legacy/tracker/create_tracker.dart';
import '../models/tracker.dart';
import '../tracker/tracker_list_screen.dart';
import '../utils/trackers_manager.dart';

class YourTrackersScreen extends StatefulWidget {
  const YourTrackersScreen({super.key});

  @override
  State<YourTrackersScreen> createState() => _YourTrackersScreenState();
}

class _YourTrackersScreenState extends State<YourTrackersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarBase(
        title: const Text(
          "Your Trackers",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey[800],
        actions: null,
      ),
      body: Stack(
        children: [
          const BaseBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<List<Tracker>>(
                    future: getAllTrackers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No trackers available.",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 30,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 1.0,
                              runSpacing: 1.0,
                              children: List.generate(
                                snapshot.data!.length,
                                (index) {
                                  return TrackerItem(
                                    name: snapshot.data![index].name,
                                    percentageCompleted:
                                        snapshot.data![index].percentage(),
                                    onLongPress: () => showDeleteDialog(
                                        snapshot.data![index], context),
                                    onPressed: () =>
                                        navigateToTrackerListScreen(
                                            snapshot.data![index], context),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              CreateTrackerButton(
                onTrackerCreation: (tracker) => {
                  setState(() {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TrackerListScreen(
                              callBackAction: () {
                                setState(() {});
                              },
                              collection: tracker);
                        },
                      ),
                    );
                  }),
                },
              ),
            ],
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
          callBackAction: () {
            setState(() {});
          },
          collection: getTracker(tracker.ref),
        ),
      ),
    );
  }
}
