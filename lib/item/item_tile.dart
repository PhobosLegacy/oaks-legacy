import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_tile.dart';
import 'package:oaks_legacy/components/pkm_image.dart';
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
    // required this.detailsPageRoute,
  });

  final bool isLowerTile;
  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function(Item) onStateChange;
  final Function(Item) onDelete;
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
      desktopContent: tileContent(pokemon, false),
      mobileContent: tileContent(pokemon, true),
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
    // return Card(
    //   child: ListTile(
    //     tileColor: widget.tileColor,
    //     textColor: Colors.black,
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) {
    //             return ItemDetailsPage(
    //               pokemons: widget.pokemons,
    //               indexes: widget.indexes,
    //               onStateChange: widget.onStateChange,
    //             );
    //           },
    //         ),
    //       );
    //       // Navigator.push(
    //       //   context,
    //       //   MaterialPageRoute(
    //       //     builder: (context) => widget.detailsPageRoute(
    //       //         widget.pokemons, widget.indexes, widget.onStateChange),
    //       //   ),
    //       // );
    //     },
    //     onLongPress: () {
    //       widget.onDelete!(pokemon);
    //     },
    //     leading: ListImage(image: "mons/${pokemon.displayImage}"),
    //     title: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(pokemon.displayName),
    //             if (pokemon.attributes.contains(PokemonAttributes.isShiny))
    //               Padding(
    //                 padding: const EdgeInsets.only(left: 3),
    //                 child: Image.network(
    //                   '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
    //                   color: Colors.black87,
    //                   height: 10,
    //                 ),
    //               ),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 if (pokemon.ability != kValueNotFound)
    //                   Text(
    //                     (pokemon.ability != kValueNotFound)
    //                         ? pokemon.ability
    //                         : "",
    //                     style: const TextStyle(
    //                         fontStyle: FontStyle.italic, fontSize: 12),
    //                   ),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 if (pokemon.gender != PokemonGender.genderless &&
    //                     pokemon.gender != PokemonGender.undefinied)
    //                   (pokemon.gender == PokemonGender.male)
    //                       ? const Padding(
    //                           padding: EdgeInsets.only(left: 3),
    //                           child: Icon(
    //                             Icons.male,
    //                             color: Colors.blue,
    //                             size: 15,
    //                           ),
    //                         )
    //                       : const Padding(
    //                           padding: EdgeInsets.only(left: 3),
    //                           child: Icon(
    //                             Icons.female,
    //                             color: Colors.red,
    //                             size: 15,
    //                           ),
    //                         ),
    //                 if (pokemon.level != "" && pokemon.level != kValueNotFound)
    //                   Text(
    //                     ' (Lvl. ${pokemon.level})',
    //                     style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 12,
    //                     ),
    //                   ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //     trailing: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         SizedBox(
    //             height: 25,
    //             child: (pokemon.ball != PokeballType.undefined)
    //                 ? Image.network(
    //                     pokemon.ball.getImagePath(),
    //                   )
    //                 : null),
    //         const SizedBox(height: 25, width: 25),
    //         SizedBox(
    //           height: 50,
    //           width: 50,
    //           child: (pokemon.originalLocation.isNotEmpty &&
    //                   pokemon.originalLocation != "Unknown" &&
    //                   pokemon.originalLocation != "")
    //               ? Image.network(
    //                   '$kImageLocalPrefix${Game.gameIcon(pokemon.originalLocation)}',
    //                 )
    //               : null,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  tileContent(Item pokemon, bool isMobileView) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: PkmImage(
            image: 'mons/${pokemon.displayImage}',
            heroTag: pokemon.ref,
            shadowOnly: false,
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