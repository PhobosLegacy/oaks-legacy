import 'package:flutter/material.dart';
import 'package:proto_dex/components/app_bar.dart';
import 'package:proto_dex/components/base_background.dart';
import 'package:proto_dex/components/switch_option.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/preferences.dart';

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
      appBar: AppBarBase(
        title: const Text("Preferences"),
        color: Colors.blueGrey[800],
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
                const Text(
                  'Your Trainer Names: ',
                  style: TextStyle(color: Colors.white),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        shadowColor: Colors.white,
                        color: Colors.blueGrey[800],
                        borderOnForeground: true,
                        child: SizedBox(
                          height: 130, // Set a fixed height for the Card
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
                                      return GestureDetector(
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (dialogContex) =>
                                              AlertDialog(
                                            title: const Text('Trainer Name'),
                                            content: TextField(
                                              controller: textController,
                                              autofocus: true,
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text("Confirm"),
                                                onPressed: () {
                                                  setState(() {
                                                    if (textController.text !=
                                                        "") {
                                                      kPreferences.trainerNames
                                                          .add(textController
                                                              .text);

                                                      kPreferences.save();
                                                    }
                                                    textController.clear();
                                                  });
                                                  Navigator.pop(dialogContex);
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Cancel"),
                                                onPressed: () {
                                                  textController.clear();
                                                  Navigator.pop(dialogContex);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        child: const Chip(
                                          shadowColor: Colors.blue,
                                          elevation: 2,
                                          label: Text(
                                            "+",
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
                                      child: Chip(
                                        label: GestureDetector(
                                          onLongPress: () {
                                            setState(() {
                                              kPreferences.trainerNames.remove(
                                                  kPreferences
                                                      .trainerNames[index]);

                                              kPreferences.save();
                                            });
                                          },
                                          child: Text(
                                            kPreferences.trainerNames[index],
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

                // Row(
                //   children: [
                //     Expanded(
                //       child: Card(
                //         shadowColor: Colors.blue,
                //         // height: 5 * 80,
                //         // color: Colors.red,
                //         child: Wrap(direction: Axis.vertical, children: [
                //           ListView.builder(
                //             itemBuilder: (context, index) {
                //               if (index == kPreferences.trainerNames.length) {
                //                 return GestureDetector(
                //                   onTap: () => showDialog(
                //                     context: context,
                //                     builder: (dialogContex) => AlertDialog(
                //                       title: const Text('Trainer Name'),
                //                       content: TextField(
                //                         controller: textController,
                //                         autofocus: true,
                //                       ),
                //                       actions: [
                //                         TextButton(
                //                           child: const Text("Confirm"),
                //                           onPressed: () {
                //                             setState(() {
                //                               if (textController.text != "") {
                //                                 kPreferences.trainerNames
                //                                     .add(textController.text);

                //                                 kPreferences.save();
                //                               }
                //                               textController.clear();
                //                             });
                //                             Navigator.pop(dialogContex);
                //                           },
                //                         ),
                //                         TextButton(
                //                           child: const Text("Cancel"),
                //                           onPressed: () {
                //                             textController.clear();
                //                             Navigator.pop(dialogContex);
                //                           },
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   child: const Chip(
                //                     shadowColor: Colors.blue,
                //                     elevation: 2,
                //                     label: Text(
                //                       "+",
                //                     ),
                //                   ),
                //                 );
                //               }
                //               return Chip(
                //                 label: GestureDetector(
                //                   onLongPress: () {
                //                     setState(() {
                //                       kPreferences.trainerNames.remove(
                //                           kPreferences.trainerNames[index]);

                //                       kPreferences.save();
                //                     });
                //                   },
                //                   child: Text(
                //                     kPreferences.trainerNames[index],
                //                   ),
                //                 ),
                //               );
                //             },
                //             itemCount: kPreferences.trainerNames.length + 1,
                //             shrinkWrap: true,
                //             padding: const EdgeInsets.all(5),
                //             scrollDirection: Axis.vertical,
                //           ),
                //         ]),
                //       ),
                //     ),
                //   ],
                // ),
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
    // return Drawer(
    //   child: ListView(
    //     padding: EdgeInsets.zero,
    //     children: [
    //       const SizedBox(
    //         height: 80,
    //         child: DrawerHeader(
    //           decoration: BoxDecoration(color: Colors.blue),
    //           child: Text('Filters'),
    //         ),
    //       ),
    //       Column(
    //         children: [],
    //       ),
    //       const Divider(thickness: 2),
    //       Center(
    //         child: TextButton(
    //           onPressed: this..pop(context),
    //           child: const Text("Close"),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
