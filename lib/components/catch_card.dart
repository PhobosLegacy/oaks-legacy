import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/enums.dart';
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
                      DateTime? date = await bottomDatePicker(context);
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
                                      builder: (dialogContex) => AlertDialog(
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
                                                if (textController.text != "") {
                                                  kPreferences.trainerNames
                                                      .add(textController.text);

                                                  kPreferences.save();

                                                  widget.pokemon.trainerName =
                                                      textController.text;
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

Future<DateTime?> bottomDatePicker(BuildContext context) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: DateTime.now(),
    // initialDate: DateTime.now().subtract(const Duration(days: 1)),
    firstDate: DateTime(2021),
    lastDate: DateTime(2050),
  );
  return date;
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
    switch (this) {
      case PokeballType.pokeball:
        return "${kImageLocalPrefix}balls/pokeball.png";
      case PokeballType.greatBall:
        return "${kImageLocalPrefix}balls/greatball.png";
      case PokeballType.ultraBall:
        return "${kImageLocalPrefix}balls/ultraball.png";
      case PokeballType.masterBall:
        return "${kImageLocalPrefix}balls/masterball.png";
      case PokeballType.premierball:
        return "${kImageLocalPrefix}balls/premierball.png";
      case PokeballType.duskball:
        return "${kImageLocalPrefix}balls/duskball.png";
      case PokeballType.cherishball:
        return "${kImageLocalPrefix}balls/cherishball.png";
      case PokeballType.quickball:
        return "${kImageLocalPrefix}balls/quickball.png";
      case PokeballType.beastball:
        return "${kImageLocalPrefix}balls/beastball.png";
      case PokeballType.luxuryball:
        return "${kImageLocalPrefix}balls/luxuryball.png";
      case PokeballType.repeatball:
        return "${kImageLocalPrefix}balls/repeatball.png";
      case PokeballType.timerball:
        return "${kImageLocalPrefix}balls/timerball.png";
      case PokeballType.undefined:
        return "${kImageLocalPrefix}balls/undefined.png";
      default:
        throw Exception("-No image found for ball: $name");
    }
  }
}

extension PokemonGenderExtensions on PokemonGender {
  Icon getIcon() {
    switch (this) {
      case PokemonGender.female:
        return const Icon(
          Icons.female,
          color: Colors.redAccent,
        );
      case PokemonGender.male:
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
    list.insert(0, kValueNotFound);
    return list;
  }
}
