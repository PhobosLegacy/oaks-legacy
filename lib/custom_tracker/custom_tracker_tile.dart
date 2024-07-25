import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_checkbox.dart';
import 'package:oaks_legacy/components/pkm_tile.dart';
import 'package:oaks_legacy/components/pkm_image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/item/item_forms.dart';
import 'package:oaks_legacy/models/enums.dart';
import '../models/item.dart';

class CustomTrackerTile extends StatefulWidget {
  const CustomTrackerTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      required this.isLowerTile,
      required this.trackerInfo,
      this.onStateChange});

  final bool isLowerTile;
  final List<Item> pokemons;
  final List<int> indexes;
  final List<String> trackerInfo;
  final Function(Item)? onStateChange;

  @override
  State<CustomTrackerTile> createState() => _CustomTrackerTile();
}

class _CustomTrackerTile extends State<CustomTrackerTile> {
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
        markAsCaptured(pokemon),
      },
    );
  }

  tileContent(Item pokemon, bool isMobileView) {
    return Row(
      children: [
        //IMAGE
        Expanded(
          flex: 2,
          child: PkmImage(
            heroTag: pokemon.ref,
            image: "mons/${pokemon.displayImage}",
            shadowOnly: kPreferences.revealUncaught == false &&
                Item.isCaptured(pokemon) != CaptureType.full,
          ),
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
                  isLocked: false,
                  onChanged: (value) {
                    markAsCaptured(pokemon);
                  },
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  markAsCaptured(Item pokemon) {
    setState(
      () {
        pokemon.captured = !pokemon.captured;
        pokemon.catchDate = (pokemon.captured) ? DateTime.now().toString() : "";
        widget.onStateChange!(pokemon);
      },
    );
  }
}
