import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/catch_card.dart';
import 'package:oaks_legacy/components/pkm_tile.dart';
import 'package:oaks_legacy/components/pkm_image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/tracker/tracker_details_screen.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    super.key,
    required this.pokemons,
    required this.indexes,
    this.tileColor,
    required this.onStateChange,
    required this.onDelete,
    required this.isLowerTile,
    required this.screenKey,
    // required this.detailsPageRoute,
  });

  final bool isLowerTile;
  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function(Item) onStateChange;
  final Function(Item) onDelete;
  final String screenKey;
  // final Widget Function(
  //         List<Item> pokemons, List<int> indexes, Function(Item)? onStateChange)
  //     detailsPageRoute;

  @override
  State<ItemTile> createState() => _ItemTile();
}

class _ItemTile extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);
    return PkmTile(
      isLowerTile: widget.isLowerTile,
      desktopContent: tileContent(
        pokemon,
        false,
      ),
      mobileContent: tileContent(
        pokemon,
        true,
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return TrackerDetailsPage(
                pokemons: widget.pokemons,
                indexes: widget.indexes,
                onStateChange: () => widget.onStateChange(pokemon),
              );
            },
          ),
        )
      },
      onLongPress: () => {widget.onDelete(pokemon)},
    );
  }

  tileContent(Item pokemon, bool isMobileView) {
    Widget pkmImage = Expanded(
      flex: 2,
      child: PkmImage(
        image: 'mons/${pokemon.displayImage}',
        heroTag: pokemon.ref,
        shadowOnly: false,
      ),
    );

    Widget pkmName = AutoSizeText(
      pokemon.displayName,
      maxLines: 1,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: (isMobileView) ? 20 : 30),
    );

    Widget shinyIcon = Image.network(
      '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
      color: Colors.amber,
      height: 25,
    );

    String lvlLabel = 'Any level';
    Widget pkmLevel = Text(
      (pokemon.level != kValueNotFound) ? 'lvl ${pokemon.level}' : lvlLabel,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: (isMobileView) ? 15 : 20),
    );

    String separator = (isMobileView) ? ' - ' : '';
    String abilityLabel = 'Any Ability';
    Widget pkmAbility = Text(
      (pokemon.ability != kValueNotFound)
          ? '$separator(${pokemon.ability})'
          : '$separator$abilityLabel',
      style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: (isMobileView) ? 15 : 20),
    );

    Widget pkmGameAndBall = SizedBox(
      height: PkmOption.size(context) / 2,
      child: Row(
        mainAxisAlignment: (isMobileView)
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            pokemon.ball.getImagePath(),
          ),
          const SizedBox(
            width: 10,
          ),
          Image.network(
            kImageLocalPrefix + Game.gameIcon(pokemon.currentLocation),
          ),
        ],
      ),
    );

    if (isMobileView) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          pkmImage,
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      pkmName,
                      if (pokemon.attributes
                          .contains(PokemonAttributes.isShiny))
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: shinyIcon,
                        ),
                      if (pokemon.gender != PokemonGender.undefinied &&
                          pokemon.gender != PokemonGender.genderless)
                        pokemon.gender.getIcon(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      pkmLevel,
                      pkmAbility,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: pkmGameAndBall,
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        pkmImage,
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: pkmName,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (pokemon.attributes.contains(PokemonAttributes.isShiny))
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: shinyIcon,
                    ),
                  if (pokemon.gender != PokemonGender.undefinied &&
                      pokemon.gender != PokemonGender.genderless)
                    pokemon.gender.getIcon(),
                ],
              ),
              pkmLevel,
              pkmAbility,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: pkmGameAndBall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/**
 * Usage:
 * 
 *CustomTile(
  key: UniqueKey(),
  pokemons: yourPokemonList,
  indexes: yourIndexesList,
  tileColor: Colors.blue, // Provide your color
  onStateChange: (Item item) {
    // Handle state change
  },
  onDelete: (Item item) {
    // Handle delete
  },
  detailsPageRoute: (List<Item> pokemons, List<int> indexes, Function(Item)? onStateChange) {
    return YourDetailsPage(pokemons: pokemons, indexes: indexes, onStateChange: onStateChange);
  },
),
 */
