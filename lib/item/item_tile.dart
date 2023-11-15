import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/catch_card.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/item/item_details_screen.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/item.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    super.key,
    required this.pokemons,
    required this.indexes,
    this.tileColor,
    required this.onStateChange,
    required this.onDelete,
    // required this.detailsPageRoute,
  });

  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function(Item)? onStateChange;
  final Function(Item)? onDelete;
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

    return Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ItemDetailsPage(
                  pokemons: widget.pokemons,
                  indexes: widget.indexes,
                  onStateChange: widget.onStateChange,
                );
              },
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => widget.detailsPageRoute(
          //         widget.pokemons, widget.indexes, widget.onStateChange),
          //   ),
          // );
        },
        onLongPress: () {
          widget.onDelete!(pokemon);
        },
        leading: ListImage(image: "mons/${pokemon.displayImage}"),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pokemon.displayName),
                if (pokemon.attributes.contains(PokemonAttributes.isShiny))
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Image.network(
                      '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
                      color: Colors.black87,
                      height: 10,
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (pokemon.ability != kValueNotFound)
                      Text(
                        (pokemon.ability != kValueNotFound)
                            ? pokemon.ability
                            : "",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 12),
                      ),
                  ],
                ),
                Row(
                  children: [
                    if (pokemon.gender != PokemonGender.genderless &&
                        pokemon.gender != PokemonGender.undefinied)
                      (pokemon.gender == PokemonGender.male)
                          ? const Padding(
                              padding: EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.male,
                                color: Colors.blue,
                                size: 15,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.female,
                                color: Colors.red,
                                size: 15,
                              ),
                            ),
                    if (pokemon.level != "" && pokemon.level != kValueNotFound)
                      Text(
                        ' (Lvl. ${pokemon.level})',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 25,
                child: (pokemon.ball != PokeballType.undefined)
                    ? Image.network(
                        pokemon.ball.getImagePath(),
                      )
                    : null),
            const SizedBox(height: 25, width: 25),
            SizedBox(
              height: 50,
              width: 50,
              child: (pokemon.originalLocation.isNotEmpty &&
                      pokemon.originalLocation != "Unknown" &&
                      pokemon.originalLocation != "")
                  ? Image.network(
                      '$kImageLocalPrefix${Game.gameIcon(pokemon.originalLocation)}',
                    )
                  : null,
            ),
          ],
        ),
      ),
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