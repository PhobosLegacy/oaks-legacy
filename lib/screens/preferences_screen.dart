import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/app_bar.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/pkm_text_dialog.dart';
import 'package:oaks_legacy/components/switch_option.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  Preferences prefs = kPreferences;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarBase(
        title: Text(
          "Preferences",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: null,
      ),
      body: Stack(
        children: [
          const BaseBackground(),
          SafeArea(
            child: Column(
              children: [
                const Divider(),
                SwitchOption(
                  title: "Display Uncaught on Trackers",
                  switchValue: kPreferences.revealUncaught,
                  onSwitch: (bool value) async {
                    kPreferences.revealUncaught = value;
                    kPreferences.save();
                    setState(() {});
                  },
                ),
                const Divider(),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Your Trainer Names: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        shadowColor: Colors.black26,
                        color: Colors.black26,
                        borderOnForeground: true,
                        child: SizedBox(
                          height: 130,
                          child: ListView(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            shrinkWrap: true,
                            children: [
                              Wrap(
                                spacing: 4.0,
                                runSpacing: -10.0,
                                children: List<Widget>.generate(
                                  kPreferences.trainerNames.length + 1,
                                  (int index) {
                                    if (index ==
                                        kPreferences.trainerNames.length) {
                                      return ZoomTapAnimation(
                                        child: GestureDetector(
                                          onTap: () => showDialog(
                                            context: context,
                                            builder: (dialogContex) =>
                                                PkmTextEditDialog(
                                                    title: 'Your Trainer Name',
                                                    textController:
                                                        textController,
                                                    onChange: () {
                                                      setState(() {
                                                        kPreferences
                                                            .trainerNames
                                                            .add(textController
                                                                .text);
                                                        kPreferences.save();
                                                      });
                                                    }),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Chip(
                                              shadowColor: Colors.blue,
                                              elevation: 2,
                                              label: Text(
                                                "+",
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return GestureDetector(
                                      onLongPress: () {
                                        setState(() {
                                          kPreferences.trainerNames.remove(
                                              kPreferences.trainerNames[index]);

                                          kPreferences.save();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Chip(
                                          label: GestureDetector(
                                            onLongPress: () {
                                              setState(() {
                                                kPreferences.trainerNames
                                                    .remove(kPreferences
                                                        .trainerNames[index]);

                                                kPreferences.save();
                                              });
                                            },
                                            child: Text(
                                              kPreferences.trainerNames[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '*Press and hold to remove*',
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
