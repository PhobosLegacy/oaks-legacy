import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/pokedex/pokedex_forms.dart';
import 'package:oaks_legacy/tracker/tracker_details_screen.dart';
import '../../components/image.dart';
import '../../models/game.dart';
import '../models/item.dart';

class TrackerTile extends StatefulWidget {
  const TrackerTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      required this.isLowerTile,
      this.onStateChange});

  final bool isLowerTile;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function()? onStateChange;

  @override
  State<TrackerTile> createState() => _TrackerTile();
}

class _TrackerTile extends State<TrackerTile> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);

    double currentWidth = MediaQuery.of(context).size.width;
    int cardsPerRow = currentWidth ~/ 400;
    double width = currentWidth / cardsPerRow - 12.0;
    double height = (cardsPerRow > 1) ? 220 : 110;

    Widget content = Column(
      children: [
        Expanded(
          flex: 10,
          child: (cardsPerRow > 1) ? dRow(pokemon) : mRow(pokemon),
        ),
        //FORMS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pokemon.forms.isNotEmpty)
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                // Icons.keyboard_double_arrow_down,
                color: Colors.white,
              ),
            Text(
              (pokemon.forms.isNotEmpty)
                  ? '${pokemon.forms.where((element) => element.captured == true).length}/${pokemon.forms.length}'
                  : "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        )
      ],
    );

    // if (pokemon.game.notes.isNotEmpty) {
    //   content = ClipRRect(
    //     child: Card(
    //       color:
    //           (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
    //       clipBehavior: Clip.antiAlias,
    //       child: Banner(
    //           message: pokemon.game.notes,
    //           location: BannerLocation.topEnd,
    //           color: getBannerColor(pokemon.game.notes),
    //           textStyle: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 9,
    //             fontWeight: FontWeight.bold,
    //           ),
    //           child: content),
    //     ),
    //   );
    // } else {
    content = Card(
      color: (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
      clipBehavior: Clip.antiAlias,
      child: content,
    );
    // }
    content = GestureDetector(
      onTap: (pokemon.forms.isEmpty)
          ? () => {
                if (pokemon.captured)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TrackerDetailsPage(
                            pokemons: widget.pokemons,
                            indexes: widget.indexes,
                            onStateChange: widget.onStateChange,
                          );
                        },
                      ),
                    ),
                  }
                else
                  {
                    setState(
                      () {
                        confettiController.play();
                        pokemon.captured = true;
                        pokemon.catchDate = DateTime.now().toString();
                        widget.onStateChange!();
                      },
                    )
                  }
              }
          : () {
              showDialog(
                barrierColor: Colors.black87,
                context: context,
                builder: (BuildContext context) {
                  return ShowItemForms(
                    isLowerTile: true,
                    pokemons: widget.pokemons,
                    indexes: [...widget.indexes],
                    onStateChange: widget.onStateChange,
                  );
                },
              );
            },
      onLongPress: () => {
        setState(
          () {
            pokemon.captured = false;
            pokemon.catchDate = "";
            widget.onStateChange!();
          },
        )
      },
      child: content,
    );

    return SizedBox(
        width: (widget.isLowerTile) ? width * 0.9 : width,
        height: (widget.isLowerTile) ? height * 0.9 : height,
        child: content);
  }

  // getName(Item pokemon) {
  //   if (!widget.isLowerTile) return pokemon.name;
  //   if (pokemon.forms.isNotEmpty) return pokemon.name;
  //   if (pokemon.formName == "") return pokemon.name;
  //   return pokemon.formName;
  // }

  mRow(Item pokemon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //IMAGE
        Stack(
          children: [
            Hero(
              tag: pokemon.ref,
              child: ListImage(
                image: "mons/${pokemon.displayImage}",
                shadowOnly: kPreferences.revealUncaught == false &&
                    Item.isCaptured(pokemon) != CaptureType.full,
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: Align(
                alignment: Alignment.bottomRight,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                      false, // start again as soon as the animation is finished
                  maximumSize: const Size(15, 15),
                  minimumSize: const Size(15, 15),
                  minBlastForce: 2,
                  maxBlastForce: 5,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                    // Colors.red,
                    // Colors.redAccent,
                    // Colors.black,
                    // Colors.white,
                    // Colors.white70
                  ], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),
            ),
          ],
        ),

        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //NAME
                    Expanded(
                      flex: (widget.isLowerTile) ? 3 : 2,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          pokemon.displayName,
                          textScaler: const TextScaler.linear(1.3),
                          // getName(pokemon),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                    ),

                    //NUMBER
                    if (!widget.isLowerTile && pokemon.number.isNotEmpty)
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "#${pokemon.number}",
                            textScaler: const TextScaler.linear(1.3),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),

                    //CAPTURED
                    Expanded(
                      child: Checkbox(
                        value: pokemon.captured,
                        onChanged: (value) {
                          setState(
                            () {
                              pokemon.captured = value!;
                              pokemon.catchDate =
                                  (value) ? DateTime.now().toString() : "";
                              widget.onStateChange!();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //EXCLUSIVE?
              if (pokemon.game.notes.isNotEmpty)
                Card(
                  color: getBannerColor(pokemon.game.notes),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pokemon.game.notes,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // //EXCLUSIVE?
        // if (pokemon.game.notes.isNotEmpty)
        //   Card(
        //     color: getBannerColor(pokemon.game.notes),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           pokemon.game.notes,
        //           style: const TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //               fontSize: 10),
        //         ),
        //       ],
        //     ),
        //   ),
      ],
    );
  }

  dRow(Item pokemon) {
    return Row(
      children: [
        Stack(
          children: [
            Hero(
              tag: pokemon.ref,
              child: ListImage(
                image: "mons/${pokemon.displayImage}",
                shadowOnly: kPreferences.revealUncaught == false &&
                    Item.isCaptured(pokemon) != CaptureType.full,
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Align(
                alignment: Alignment.bottomRight,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                      false, // start again as soon as the animation is finished
                  maximumSize: const Size(15, 15),
                  minimumSize: const Size(15, 15),
                  minBlastForce: 2,
                  maxBlastForce: 5,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                    // Colors.red,
                    // Colors.redAccent,
                    // Colors.black,
                    // Colors.white,
                    // Colors.white70
                  ], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: (widget.isLowerTile)
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              //NAME
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        pokemon.displayName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),

              //NUMBER
              if (!widget.isLowerTile && pokemon.number.isNotEmpty)
                Expanded(
                  child: Text(
                    "#${pokemon.number}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                ),

              //EXCLUSIVE?
              (pokemon.game.notes.isNotEmpty)
                  ? Card(
                      color: getBannerColor(pokemon.game.notes),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pokemon.game.notes,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 13,
                    ),

              //CAPTURED
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: pokemon.captured,
                  onChanged: (value) {
                    setState(
                      () {
                        pokemon.captured = value!;
                        pokemon.catchDate =
                            (value) ? DateTime.now().toString() : "";
                        widget.onStateChange!();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getBannerColor(gameNotes) {
    switch (gameNotes) {
      case "Violet Exclusive":
        return Game.gameColor("Pokemon Violet");
      case "Scarlet Exclusive":
        return Game.gameColor("Pokemon Scarlet");
      case "Sword Exclusive":
        return Game.gameColor("Pokemon Sword");
      case "Shield Exclusive":
        return Game.gameColor("Pokemon Shield");
      case "Pikachu Exclusive":
        return Game.gameColor("Let's Go Pikachu");
      case "Eevee Exclusive":
        return Game.gameColor("Let's Go Eevee");
      default:
        return Colors.black;
    }
  }
}
