import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_checkbox.dart';
import 'package:oaks_legacy/components/pkm_confetti.dart';
import 'package:oaks_legacy/components/pkm_tile.dart';
import 'package:oaks_legacy/components/pkm_tile_image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/pokedex/pokedex_forms.dart';
import 'package:oaks_legacy/tracker/tracker_details_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);
    return PkmTile(
      isLowerTile: widget.isLowerTile,
      desktopContent: tileContent(pokemon, false),
      mobileContent: tileContent(pokemon, true),
      onTap: () => {
        (pokemon.forms.isEmpty)
            ? (pokemon.captured)
                ? null //navigateToTrackerDetailsPage()
                : markAsCaptured(pokemon)
            : openFormsDialog()
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
    );
  }

  tileContent(Item pokemon, bool isMobileView) {
    return Row(
      children: [
        //IMAGE + CONFETTI
        Stack(
          children: [
            PkmTileImage(
              heroTag: pokemon.ref,
              image: "mons/${pokemon.displayImage}",
              shadowOnly: kPreferences.revealUncaught == false &&
                  Item.isCaptured(pokemon) != CaptureType.full,
            ),
            PkmConfetti(
              confettiController: confettiController,
              scaleUp: !isMobileView,
            ),
          ],
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              //NAME
              Expanded(
                flex: (widget.isLowerTile) ? 3 : 2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    pokemon.displayName,
                    textScaler: const TextScaler.linear(1.3),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: (isMobileView) ? 15 : 30),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (isMobileView) ? 12 : 25),
                    ),
                  ),
                ),

              //EXCLUSIVE?
              Expanded(
                flex: (isMobileView) ? 2 : 1,
                child: (pokemon.game.notes.isNotEmpty)
                    ? Card(
                        color: Game.getGameExclusiveBannerColor(
                            pokemon.game.notes),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              pokemon.game.notes,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: (isMobileView) ? 15 : 13),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),

              //HAS FORMS TO EXPAND
              Expanded(
                child: (pokemon.forms.isNotEmpty)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (pokemon.forms.isNotEmpty)
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              // Icons.keyboard_double_arrow_down,
                              color: Colors.white,
                            ),
                          Text(
                            '${pokemon.forms.where((element) => element.captured == true).length}/${pokemon.forms.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (isMobileView) ? 10 : 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              )
            ],
          ),
        ),

        //CAPTURED
        Expanded(
          child: (pokemon.forms.isEmpty)
              ? PkmCheckbox(
                  scale: !isMobileView,
                  value: pokemon.captured,
                  onChanged: (value) {
                    setState(
                      () {
                        if (value == true) confettiController.play();
                        pokemon.captured = value!;
                        pokemon.catchDate =
                            (value) ? DateTime.now().toString() : "";
                        widget.onStateChange!();
                      },
                    );
                  },
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  navigateToTrackerDetailsPage() {
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
    );
  }

  markAsCaptured(Item pokemon) {
    setState(
      () {
        confettiController.play();
        pokemon.captured = true;
        pokemon.catchDate = DateTime.now().toString();
        widget.onStateChange!();
      },
    );
  }

  openFormsDialog() {
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
  }
}
