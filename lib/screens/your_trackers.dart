import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/app_bar.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/pkm_button.dart';
import 'package:oaks_legacy/components/pkm_scrollbar.dart';
import 'package:oaks_legacy/components/pkm_text_dialog.dart';
import 'package:oaks_legacy/components/progress_bar.dart';
import 'package:oaks_legacy/tracker/create_tracker.dart';
import 'package:oaks_legacy/models/tracker.dart';
import 'package:oaks_legacy/tracker/tracker_list_screen.dart';
import 'package:oaks_legacy/utils/trackers_manager.dart';

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
      appBar: const AppBarBase(
        title: Text(
          "Your Trackers",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: null,
      ),
      body: Stack(
        children: [
          const BaseBackground(),
          Center(
            child: Column(
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
                        child: PkmScrollbar(
                          scrollController: ScrollController(),
                          child: SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 1.0,
                              runSpacing: 1.0,
                              children: List.generate(
                                snapshot.data!.length,
                                (index) {
                                  return PkmButton(
                                      buttonName: snapshot.data![index].name,
                                      onLongPress: () => showDeleteDialog(
                                          snapshot.data![index], context),
                                      onPressed: () =>
                                          navigateToTrackerListScreen(
                                              snapshot.data![index], context),
                                      auxWidget: ProgressBar(
                                        percentage: double.parse(
                                          snapshot.data![index].percentage(),
                                        ),
                                      ),
                                      textColor: Colors.white,
                                      buttonColor: Colors.black45);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                PkmButton(
                  buttonName: "NEW TRACKER",
                  onPressed: () => {
                    showDialog(
                      barrierColor: Colors.black87,
                      context: context,
                      builder: (BuildContext context) {
                        return CreateTrackerScreen(
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
                        );
                      },
                    )
                  },
                  textColor: Colors.black,
                  buttonColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(Tracker tracker, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => PkmTextDialog(
        title: 'Delete Tracker',
        content: 'Remove ${tracker.name}?',
        onConfirm: () async {
          await deleteTracker(tracker.ref);
          setState(() {});
        },
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
          collection: tracker,
        ),
      ),
    );
  }
}
