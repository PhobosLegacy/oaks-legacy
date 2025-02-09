import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oaks_legacy/components/pkm_tile.dart';
import 'package:oaks_legacy/components/pkm_image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
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
  TextEditingController textEditingController = TextEditingController();
  bool isEditEnable = false;

  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);
    textEditingController.text = pokemon.number;
    return PkmTile(
      isLowerTile: widget.isLowerTile,
      desktopContent: tileContent(pokemon, false),
      mobileContent: tileContent(pokemon, true),
      onTap: () => {},
    );
  }

  tileContent(Item pokemon, bool isMobileView) {
    Widget pokeImage = Expanded(
      flex: 2,
      child: PkmImage(
        heroTag: pokemon.ref,
        image: "mons/${pokemon.displayImage}",
        shadowOnly: kPreferences.revealUncaught == false &&
            Item.isCaptured(pokemon) != CaptureType.full,
      ),
    );

    //NAME
    Widget pokeName = Expanded(
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
    );

    //NUMBER
    Widget pokeNumber = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '#',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          SizedBox(
            width: 60,
            child: TextField(
              cursorColor: Colors.amber,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
              // focusedBorder: ...
              // border: ...,
              onChanged: (value) {
                pokemon.number = textEditingController.text.replaceAll('#', '');
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              enabled: true,
              controller: textEditingController,

              //  textScaler: const TextScaler.linear(1.3),
              style: TextStyle(
                  color: Colors.white, fontSize: (isMobileView) ? 12 : 25),
            ),
          ),
        ],
      ),
    );

    Widget pokeButtons = //ICONS
        Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Tooltip(
            message: 'Pokemon is shiny',
            child: ZoomTapAnimation(
              child: GestureDetector(
                  onTap: () {
                    if (pokemon.attributes
                        .contains(PokemonAttributes.isShiny)) {
                      pokemon.attributes.remove(PokemonAttributes.isShiny);
                    } else {
                      pokemon.attributes.add(PokemonAttributes.isShiny);
                    }
                    pokemon.displayImage = pokemon.updateDisplayImage();
                    setState(() {});
                  },
                  child:
                      (pokemon.attributes.contains(PokemonAttributes.isShiny))
                          ? const Icon(
                              Icons.auto_awesome,
                              color: Colors.amber,
                              size: 30,
                            )
                          : const Icon(
                              Icons.auto_awesome_rounded,
                              color: Colors.grey,
                              size: 30,
                            )
                  // : Image.network(
                  //     '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
                  //     color: Colors.grey,
                  //     height: 25,
                  //     width: 25,
                  //   ),
                  ),
            ),
          ),
          Tooltip(
            message: 'Pokemon has costume',
            child: ZoomTapAnimation(
              child: GestureDetector(
                  onTap: () {
                    if (pokemon.attributes
                        .contains(PokemonAttributes.hasCostume)) {
                      pokemon.attributes.remove(PokemonAttributes.hasCostume);
                    } else {
                      pokemon.attributes.add(PokemonAttributes.hasCostume);
                    }
                    setState(() {});
                  },
                  child: (pokemon.attributes
                          .contains(PokemonAttributes.hasCostume))
                      ? const Icon(
                          Icons.yard_rounded,
                          color: Colors.amber,
                          size: 30,
                        )
                      : const Icon(
                          Icons.yard_outlined,
                          color: Colors.grey,
                          size: 30,
                        )
                  // : Image.network(
                  //     '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
                  //     color: Colors.grey,
                  //     height: 25,
                  //     width: 25,
                  //   ),
                  ),
            ),
          ),
        ],
      ),
    );

    return Row(
      children: [
        //IMAGE
        pokeImage,

        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                pokeName,
                pokeNumber,
                pokeButtons,
              ]),
        ),

        //DELETE
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                markAsCaptured(pokemon);
              },
              icon: Icon(
                Icons.delete,
                size: (isMobileView) ? 25 : 30,
                color: Colors.white,
              ),
            ),
          ),
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
