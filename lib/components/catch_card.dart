import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oaks_legacy/components/pkm_text_dialog.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import '../../components/basic.dart';
import '../../models/game.dart';
import '../../models/item.dart';
import '../../models/pokemon.dart';

class CatchInformationCard extends StatefulWidget {
  const CatchInformationCard({
    super.key,
    required this.pokemon,
    this.isEditable = false,
    this.locks,
  });

  final Item pokemon;
  final bool isEditable;
  final List<DetailsLock>? locks;
  @override
  State<CatchInformationCard> createState() => _CatchInformationCardState();
}

class _CatchInformationCardState extends State<CatchInformationCard> {
  List<Item> originalList = [];
  @override
  void initState() {
    super.initState();
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "",
      cardChild: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  //BALL
                  EditableButton(
                    isEditable: editCheck(DetailsLock.ball),
                    currentValue: SizedBox(
                      height: 40,
                      child: Image.network(
                        widget.pokemon.ball.getImagePath(),
                      ),
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 2.0,
                          children: List.generate(
                            PokeballType.values.length,
                            (index2) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.ball =
                                        PokeballType.values[index2];
                                  }),
                                },
                                child: Card(
                                  color: Colors.black,
                                  child: Image.network(
                                    PokeballType.values[index2].getImagePath(),
                                    height: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                    },
                  ),

                  //ABILITY
                  EditableButton(
                    isEditable: editCheck(DetailsLock.ability),
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          Text(
                            widget.pokemon.ability,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                          const ItemName(text: "Ability"),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            List<dynamic> abilities =
                                widget.pokemon.allAbilities();
                            return SizedBox(
                              height: 40,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.ability = abilities[index];
                                  }),
                                },
                                child: Center(
                                  child: Text(
                                    abilities[index],
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: widget.pokemon.allAbilities().length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        );
                      });
                    },
                  ),

                  // LEVEL
                  EditableButton(
                    isEditable: editCheck(DetailsLock.level),
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          Text(
                            widget.pokemon.level,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                          const ItemName(text: "Level"),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        var levels = List<String>.generate(
                            100, (i) => (i + 1).toString());
                        levels.insert(0, kValueNotFound);
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 40,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.level = levels[index];
                                  }),
                                },
                                child: Center(
                                  child: Text(
                                    levels[index],
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: levels.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        );
                      });
                    },
                  ),

                  // GENDER
                  EditableButton(
                    isEditable: editCheck(DetailsLock.gender),
                    // currentValue: widget.pokemon.gender.getIcon(),
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          widget.pokemon.gender.getIcon(),
                          const ItemName(text: "Gender"),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        List<PokemonGender> genders = [
                          PokemonGender.male,
                          PokemonGender.female,
                          PokemonGender.undefinied
                        ];
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 40,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.gender = genders[index];
                                  }),
                                },
                                child: Center(
                                  child: genders[index].getIcon(),
                                ),
                              ),
                            );
                          },
                          itemCount: genders.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  //Catch Date
                  EditableButton(
                    isEditable: editCheck(DetailsLock.captureDate),
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(DateTime.parse(widget
                                .pokemon
                                .catchDate)), //format(widget.pokemon.catchDate),
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                          const ItemName(text: "Captured On", size: 20),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      DateTime current =
                          DateTime.parse(widget.pokemon.catchDate);
                      DateTime? date = await bottomDatePicker(context, current);
                      widget.pokemon.catchDate = date.toString();
                      setState(() {});
                    },
                  ),

                  //OT
                  EditableButton(
                    isEditable: editCheck(DetailsLock.originalTrainer),
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          Text(
                            widget.pokemon.trainerName,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                          const ItemName(
                            text: "Original Trainer",
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            //addds the "Add new Options"
                            if (index == kPreferences.trainerNames.length) {
                              return SizedBox(
                                height: 40,
                                child: GestureDetector(
                                  onTap: () => {
                                    Navigator.pop(context),
                                    //   setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (dialogContex) =>
                                          PkmTextEditDialog(
                                              title: 'Trainer Name',
                                              textController: textController,
                                              onChange: () {
                                                setState(() {
                                                  if (textController.text !=
                                                      "") {
                                                    kPreferences.trainerNames
                                                        .add(textController
                                                            .text);

                                                    kPreferences.save();

                                                    widget.pokemon.trainerName =
                                                        textController.text;
                                                  }
                                                });
                                              }),
                                    ),
                                  },
                                  child: const Center(
                                    child: Text(
                                      '[New...]',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox(
                              height: 40,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.trainerName =
                                        kPreferences.trainerNames[index];
                                  }),
                                },
                                child: Center(
                                  child: Text(
                                    kPreferences.trainerNames[index],
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: kPreferences.trainerNames.length + 1,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        );
                      });
                    },
                  ),

                  //Method
                  EditableButton(
                    isEditable: editCheck(DetailsLock.capturedMethod),
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          Image.network(
                            kImageLocalPrefix +
                                (widget.pokemon.capturedMethod.getMethodIcon()),
                            height: 40,
                          ),
                          const ItemName(
                            text: "Method",
                            size: 15,
                          ),
                          // Text(
                          //   widget.pokemon.capturedMethod.getMethodName(),
                          //   style: const TextStyle(
                          //       fontSize: 25, color: Colors.white),
                          // ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 40,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.capturedMethod =
                                        CaptureMethod.values[index];
                                  }),
                                },
                                child: Center(
                                  child: Text(
                                    CaptureMethod.values[index].getMethodName(),
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: CaptureMethod.values.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  //Origin Game
                  EditableButton(
                    isEditable: editCheck(DetailsLock.gameOrigin),
                    currentValue: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ItemName(text: 'From: '),
                        SizedBox(
                          height: 40,
                          child: Image.network(
                            kImageLocalPrefix +
                                Game.gameIcon(widget.pokemon.originalLocation),
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 2.0,
                          children: List.generate(
                            Dex.allGames().length,
                            (index2) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.originalLocation =
                                        Dex.allGames()[index2];
                                  }),
                                },
                                child: Card(
                                  color: Colors.black,
                                  child: Image.network(
                                    kImageLocalPrefix +
                                        Game.gameIcon(Dex.allGames()[index2]),
                                    height: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                    },
                  ),

                  //Current Location
                  EditableButton(
                    isEditable: editCheck(DetailsLock.gameCurrently),
                    currentValue: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const FittedBox(child: ItemName(text: 'Currently On:')),
                        SizedBox(
                          height: 40,
                          child: Image.network(
                            kImageLocalPrefix +
                                Game.gameIcon(widget.pokemon.currentLocation),
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 2.0,
                          children: List.generate(
                            Dex.allGames().length,
                            (index2) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.currentLocation =
                                        Dex.allGames()[index2];
                                  }),
                                },
                                child: Card(
                                  color: Colors.black,
                                  child: Image.network(
                                    kImageLocalPrefix +
                                        Game.gameIcon(Dex.allGames()[index2]),
                                    height: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // ATTRIBUTES
                  EditableButton(
                    isEditable: editCheck(DetailsLock.attributes),
                    currentValue: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const FittedBox(
                          child: ItemName(text: 'Attributes'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            widget.pokemon.attributes.length,
                            (index) => Text(
                              widget.pokemon.attributes[index]
                                  .getAttributeName(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            if (index == PokemonAttributes.values.length) {
                              return Center(
                                child: TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                  },
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              );
                            }
                            return StatefulBuilder(
                              builder: (context, setLocalState) =>
                                  CheckboxListTile(
                                title: Text(
                                  PokemonAttributes.values[index]
                                      .getAttributeName(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: (isAttibuteLocked(
                                            PokemonAttributes.values[index]))
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                  ),
                                ),
                                value: widget.pokemon.attributes
                                    .contains(PokemonAttributes.values[index]),
                                activeColor: (isAttibuteLocked(
                                        PokemonAttributes.values[index]))
                                    ? Colors.grey
                                    : null,
                                onChanged: (value) {
                                  if (!isAttibuteLocked(
                                      PokemonAttributes.values[index])) {
                                    setLocalState(() {
                                      if (value!) {
                                        widget.pokemon.attributes.add(
                                            PokemonAttributes.values[index]);
                                      } else {
                                        widget.pokemon.attributes.remove(
                                            PokemonAttributes.values[index]);
                                      }
                                    });

                                    setState(() {});
                                  }
                                },
                              ),
                            );
                          },
                          itemCount: PokemonAttributes.values.length + 1,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool editCheck(DetailsLock lockType) {
    if (widget.locks == null) return widget.isEditable;
    if (widget.locks!.contains(lockType)) {
      return false;
    }
    return widget.isEditable;
  }

  bool isAttibuteLocked(PokemonAttributes attibute) {
    switch (attibute) {
      case PokemonAttributes.isAlpha:
        return widget.locks!.contains(DetailsLock.attributesAlpha);
      case PokemonAttributes.isShiny:
        return widget.locks!.contains(DetailsLock.attributesShiny);
      default:
        return false;
    }
  }
}

class ItemName extends StatelessWidget {
  const ItemName({
    required this.text,
    this.size,
    super.key,
  });

  final String text;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.amber,
        fontSize: size,
      ),
    );
  }
}

class EditableButton extends StatelessWidget {
  const EditableButton({
    super.key,
    required this.isEditable,
    required this.currentValue,
    required this.onPressed,
  });

  final bool isEditable;
  final Widget currentValue;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: (isEditable) ? onPressed : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: (isEditable)
              ? BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.yellow))
              : null,
          child: SizedBox(child: Center(child: currentValue)),
        ),
      ),
    );
  }
}

Future<DateTime?> bottomDatePicker(
    BuildContext context, DateTime currentTime) async {
  DateTime? date = await showDatePicker(
    barrierColor: Colors.black87,
    context: context,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: DateTime.now(),
    firstDate: DateTime(2021),
    lastDate: DateTime(2050),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.grey, // Change the header background color
            onPrimary: Colors.white, // Change the header text color
            surface: Color(0xFF1D1E33), // Change the background color
            onSurface: Colors.white, // Change the text color
          ),
          // dialogBackgroundColor:
          //     Colors.yellow, // Change the dialog background color
        ),
        child: child!,
      );
    },
  );
  return (date == null) ? currentTime : date;
}

Future<dynamic> bottomSheetOptions(
  BuildContext context,
  Widget Function(BuildContext) builder,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    backgroundColor: Colors.black45,
    context: context,
    builder: builder,
  );
}

extension Extensions3 on CaptureMethod {
  String getMethodName() {
    switch (this) {
      case CaptureMethod.egg:
        return 'Egg';
      case CaptureMethod.raid:
        return 'Raid';
      case CaptureMethod.trade:
        return 'Trade';
      case CaptureMethod.wild:
        return 'Wild';
      case CaptureMethod.event:
        return 'Event';
      default:
        return 'Unknown';
    }
  }

  String getMethodIcon() {
    switch (this) {
      case CaptureMethod.egg:
        return 'catch/egg.png';
      case CaptureMethod.raid:
        return 'catch/raid.png';
      case CaptureMethod.trade:
        return 'catch/trade.png';
      case CaptureMethod.wild:
        return 'catch/wild.png';
      case CaptureMethod.event:
        return 'catch/event.png';
      default:
        return 'games/colored_ball.png';
    }
  }
}

extension Extensions2 on PokemonAttributes {
  String getAttributeName() {
    switch (this) {
      case PokemonAttributes.isAlpha:
        return 'Alpha';
      case PokemonAttributes.isShiny:
        return 'Shiny';
    }
  }
}

extension Extensions on PokeballType {
  String getImagePath() {
    return "${kImageLocalPrefix}balls/${name.toLowerCase()}.png";
  }

  String getBallName() {
    switch (this) {
      case PokeballType.pokeball:
        return "Pokeball";
      case PokeballType.greatBall:
        return "Great Ball";
      case PokeballType.ultraBall:
        return "Ultra Ball";
      case PokeballType.masterBall:
        return "Master Ball";
      case PokeballType.premierball:
        return "Premier Ball";
      case PokeballType.duskball:
        return "Dusk Ball";
      case PokeballType.quickball:
        return "Quick Ball";
      case PokeballType.luxuryball:
        return "Luxury Ball";
      case PokeballType.repeatball:
        return "Repeat Ball";
      case PokeballType.timerball:
        return "Timer Ball";
      case PokeballType.netball:
        return "Net Ball";
      case PokeballType.nestball:
        return "Nest Ball";
      case PokeballType.diveball:
        return "Dive Ball";
      case PokeballType.heavyball:
        return "Heavy Ball";
      case PokeballType.levelball:
        return "Level Ball";
      case PokeballType.loveball:
        return "Love Ball";
      case PokeballType.moonball:
        return "Moon Ball";
      case PokeballType.lureball:
        return "Lure Ball";
      case PokeballType.dreamball:
        return "Dream Ball";
      case PokeballType.healball:
        return "Heal Ball";
      case PokeballType.friendball:
        return "Friend Ball";
      case PokeballType.fastball:
        return "Fast Ball";
      case PokeballType.sportball:
        return "Sport Ball";
      case PokeballType.safariball:
        return "Safari Ball";
      case PokeballType.beastball:
        return "Beast Ball";
      case PokeballType.hisuipokeball:
        return "Hisui Pokeball";
      case PokeballType.hisuigreatball:
        return "Hisui Great Ball";
      case PokeballType.hisuiultraball:
        return "Hisui Ultra Ball";
      case PokeballType.hisuifeatherball:
        return "Hisui Feather Ball";
      case PokeballType.hisuiwingball:
        return "Hisui Wing Ball";
      case PokeballType.hisuijetball:
        return "Hisui Jet Ball";
      case PokeballType.hisuiheavyball:
        return "Hisui Heavy Ball";
      case PokeballType.hisuileadenball:
        return "Hisui Leaden Ball";
      case PokeballType.hisuigigatonball:
        return "Hisui Gigaton Ball";
      case PokeballType.originball:
        return "Origin Ball";
      case PokeballType.strangeball:
        return "Strange Ball";
      case PokeballType.parkball:
        return "Park Ball";
      case PokeballType.cherishball:
        return "Cherish Ball";
      default:
        return "Unknown";
    }
  }
}

extension PokemonGenderExtensions on PokemonGender {
  Icon getIcon() {
    switch (this) {
      case PokemonGender.female:
      case PokemonGender.femaleOnly:
        return const Icon(
          Icons.female,
          color: Colors.redAccent,
        );
      case PokemonGender.male:
      case PokemonGender.maleOnly:
        return const Icon(
          Icons.male,
          color: Colors.blueAccent,
        );
      case PokemonGender.genderless:
        return const Icon(
          Icons.close,
          color: Colors.white,
        );
      case PokemonGender.undefinied:
        return const Icon(
          Icons.question_mark,
          color: Colors.white,
        );
    }
  }

  String getSingleLetter() {
    switch (this) {
      case PokemonGender.female:
        return "F";
      case PokemonGender.male:
        return "M";
      default:
        return "";
    }
  }
}

extension ItemExtensions on Item {
  List<dynamic> allAbilities() {
    Pokemon dexMon =
        kPokedex.firstWhere((element) => element.number == natDexNumber);
    List<dynamic> list = [];
    list.addAll(dexMon.abilities);
    if (dexMon.hiddenAbility! != "") list.add(dexMon.hiddenAbility);
    // list.insert(0, kValueNotFound);
    list.add(kValueNotFound);
    return list;
  }
}
