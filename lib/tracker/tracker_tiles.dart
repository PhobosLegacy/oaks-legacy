import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/tracker/tracker_details_screen.dart';
import '../../components/image.dart';
import '../../models/game.dart';
import '../models/item.dart';

class TrackerTile extends StatefulWidget {
  const TrackerTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      this.tileColor,
      this.onStateChange});

  final Color? tileColor;
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

    Card card = Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () => {
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
        },
        onLongPress: () {
          setState(
            () {
              pokemon.captured = false;
              pokemon.catchDate = "";
              widget.onStateChange!();
            },
          );
        },
        leading: Stack(
          children: [
            ListImage(
                image: "mons/${pokemon.displayImage}",
                shadowOnly:
                    kPreferences.revealUncaught == false && !pokemon.captured),
            SizedBox(
              height: 20,
              width: 20,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pokemon.displayName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (pokemon.number != "") Text("#${pokemon.number}")
          ],
        ),
        trailing: Checkbox(
          value: pokemon.captured,
          onChanged: (value) {
            setState(
              () {
                pokemon.captured = value!;
                pokemon.catchDate = (value) ? DateTime.now().toString() : "";
                widget.onStateChange!();
              },
            );
          },
        ),
      ),
    );

    if (pokemon.game.notes != "") {
      return ClipRect(
        child: Banner(
          message: "Trade Only",
          location: BannerLocation.topEnd,
          color: getBannerColor(pokemon.game.notes),
          child: card,
        ),
      );
    }

    return card;
  }

  getBannerColor(gameNotes) {
    switch (gameNotes) {
      case "Violet Exclusive":
        return Game.gameColor("Pokemon Violet");
      case "Scarlet Exclusive":
        return Game.gameColor("Pokemon Scarlet");
      case "Pikachu Exclusive":
        return Game.gameColor("Let's Go Pikachu");
      case "Eevee Exclusive":
        return Game.gameColor("Let's Go Eevee");
      default:
        return Colors.black;
    }
  }
}
