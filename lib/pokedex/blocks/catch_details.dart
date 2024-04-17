import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/components/catch_card.dart';
import 'package:oaks_legacy/components/options.dart';
import 'package:oaks_legacy/components/pkm_edit_button.dart';
import 'package:oaks_legacy/components/pkm_level_picker.dart';
import 'package:oaks_legacy/components/pkm_name_picker.dart';
import 'package:oaks_legacy/components/pkm_tile.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/item.dart';

class CatchDetailsBlock extends StatefulWidget {
  const CatchDetailsBlock({
    super.key,
    required this.pokemon,
    required this.isEditMode,
    required this.editLocks,
  });

  final Item pokemon;
  final bool isEditMode;
  final List<DetailsLock>? editLocks;

  @override
  State<CatchDetailsBlock> createState() => _CatchDetailsBlockState();
}

class _CatchDetailsBlockState extends State<CatchDetailsBlock> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = (MediaQuery.of(context).size.width < 400);
    Widget mainContent = Expanded(
      child: Card(
        color: Colors.black12,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  //BALL
                  PkmEditableButton(
                    title: widget.pokemon.ball.getBallName(),
                    isEnabled: checkLocks(DetailsLock.ball),
                    onTap: () async {
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (BuildContext context) {
                          return ShowOptions(
                            items: PokeballType.values.map((ball) {
                              return PkmOption(
                                onTap: () => {
                                  setState(() {
                                    Navigator.pop(context);
                                    widget.pokemon.ball = ball;
                                  }),
                                },
                                content: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(ball.getImagePath(),
                                      height: 100),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        widget.pokemon.ball.getImagePath(),
                      ),
                    ),
                  ),

                  //ABILITY
                  PkmEditableButton(
                    title: "Ability",
                    isEnabled: checkLocks(DetailsLock.ability),
                    onTap: () async {
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (BuildContext context) {
                          List<dynamic> abilities =
                              widget.pokemon.allAbilities();
                          return ShowOptions(
                            items: abilities.map((ability) {
                              return PkmOption(
                                onTap: () => {
                                  setState(() {
                                    Navigator.pop(context);
                                    widget.pokemon.ability = ability;
                                  }),
                                },
                                content: SizedBox(
                                    width: 200,
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        ability,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                    )),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    content: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.pokemon.ability,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //LEVEL
                  PkmEditableButton(
                    title: "Level",
                    isEnabled: checkLocks(DetailsLock.level),
                    onTap: () async {
                      (widget.pokemon.level == kValueNotFound)
                          ? textController.text = "1"
                          : textController.text =
                              widget.pokemon.level.toString();
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (dialogContex) {
                          return PkmLevelPicker(
                            textController: textController,
                            dialogContext: context,
                            onChange: () {
                              setState(() {
                                widget.pokemon.level = textController.text;
                              });
                            },
                          );
                        },
                      );
                    },
                    content: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.pokemon.level,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //GENDER
                  PkmEditableButton(
                    title: "Gender",
                    isEnabled: checkLocks(DetailsLock.gender),
                    onTap: () async {
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (BuildContext context) {
                          List<PokemonGender> genders = [
                            PokemonGender.male,
                            PokemonGender.female,
                            PokemonGender.undefinied
                          ];
                          return ShowOptions(
                            items: genders.map((gender) {
                              return PkmOption(
                                onTap: () => {
                                  setState(() {
                                    Navigator.pop(context);
                                    widget.pokemon.gender = gender;
                                  }),
                                },
                                content: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Transform.scale(
                                        scale: 2, child: gender.getIcon()),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    content: Transform.scale(
                        scale: (isSmallScreen) ? 1.5 : 3,
                        child: widget.pokemon.gender.getIcon()),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  //CAPTURED DATE
                  PkmEditableButton(
                    title: "Captured On",
                    isEnabled: checkLocks(DetailsLock.captureDate),
                    onTap: () async {
                      DateTime current =
                          DateTime.parse(widget.pokemon.catchDate);
                      DateTime? date = await bottomDatePicker(context, current);
                      widget.pokemon.catchDate = date.toString();
                      setState(() {});
                    },
                    content: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(widget.pokemon.catchDate),
                          ), //format(widget.widget.pokemon.catchDate),
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //OT
                  PkmEditableButton(
                    title: "OT",
                    isEnabled: checkLocks(DetailsLock.originalTrainer),
                    onTap: () async {
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (BuildContext context) {
                          return ShowOptions(
                            items: [
                              ...kPreferences.trainerNames.map((trainerName) {
                                return PkmOption(
                                  onTap: () {
                                    setState(() {
                                      Navigator.pop(context);
                                      widget.pokemon.trainerName = trainerName;
                                    });
                                  },
                                  content: SizedBox(
                                    width: 200,
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        trainerName,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              PkmOption(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierColor: Colors.black87,
                                      builder: (BuildContext otContext) {
                                        return PkmNamePicker(
                                            textController: textController,
                                            onChange: () {
                                              setState(() {
                                                kPreferences.trainerNames
                                                    .add(textController.text);
                                                Navigator.pop(context);
                                                kPreferences.save();
                                                widget.pokemon.trainerName =
                                                    textController.text;
                                              });
                                            },
                                            dialogContext: context);
                                      });
                                },
                                content: const SizedBox(
                                  width: 200,
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      '[Add New Trainer]',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    content: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.pokemon.trainerName,
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //CAPTURE METHOD
                  PkmEditableButton(
                    title: "Method",
                    isEnabled: checkLocks(DetailsLock.capturedMethod),
                    onTap: () async {
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (BuildContext context) {
                          return ShowOptions(
                            items: CaptureMethod.values.map((method) {
                              return PkmOption(
                                onTap: () => {
                                  setState(() {
                                    Navigator.pop(context);
                                    widget.pokemon.capturedMethod = method;
                                  }),
                                },
                                content: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                          kImageLocalPrefix +
                                              method.getMethodIcon(),
                                          height: 100),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        method.getMethodName(),
                                        style: const TextStyle(
                                            color: Colors.amber),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        kImageLocalPrefix +
                            (widget.pokemon.capturedMethod.getMethodIcon()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  //ORIGIN GAME
                  PkmEditableButton(
                    title: "Caught On",
                    isEnabled: checkLocks(DetailsLock.gameOrigin),
                    onTap: () async {
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (BuildContext context) {
                          return ShowOptions(
                            items: Dex.allGames().toList().map((game) {
                              return PkmOption(
                                onTap: () => {
                                  setState(() {
                                    Navigator.pop(context);
                                    widget.pokemon.originalLocation = game;
                                  }),
                                },
                                content: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                          kImageLocalPrefix +
                                              Game.gameIcon(game),
                                          height: 100),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        game,
                                        style: const TextStyle(
                                            color: Colors.amber),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        kImageLocalPrefix +
                            Game.gameIcon(widget.pokemon.originalLocation),
                      ),
                    ),
                  ),

                  //CURRENT GAME
                  PkmEditableButton(
                    title: "Currently On",
                    isEnabled: checkLocks(DetailsLock.gameCurrently),
                    onTap: () async {
                      showDialog(
                        barrierColor: Colors.black87,
                        context: context,
                        builder: (BuildContext context) {
                          return ShowOptions(
                            items: Dex.allGames().toList().map((game) {
                              return PkmOption(
                                onTap: () => {
                                  setState(() {
                                    Navigator.pop(context);
                                    widget.pokemon.currentLocation = game;
                                  }),
                                },
                                content: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                          kImageLocalPrefix +
                                              Game.gameIcon(game),
                                          height: 100),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        game,
                                        style: const TextStyle(
                                            color: Colors.amber),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        kImageLocalPrefix +
                            Game.gameIcon(widget.pokemon.currentLocation),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return (MediaQuery.of(context).size.width < 1024)
        ? mainContent
        : DetailsCard(cardChild: mainContent, blockTitle: "Attributes");
  }

  bool checkLocks(DetailsLock lockType) {
    if (widget.editLocks == null) return widget.isEditMode;
    if (widget.editLocks!.contains(lockType)) {
      return false;
    }
    return widget.isEditMode;
  }
}
