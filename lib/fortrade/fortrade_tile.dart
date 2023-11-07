import 'package:flutter/material.dart';
import 'package:proto_dex/components/catch_card.dart';
import 'package:proto_dex/fortrade/fortrade_details_screen.dart';
import '../components/image.dart';
import '../constants.dart';
import '../models/enums.dart';
import '../models/game.dart';
import '../models/item.dart';

class ForTradeTile extends StatefulWidget {
  const ForTradeTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      this.tileColor,
      this.onStateChange,
      this.onDelete});

  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function(Item)? onStateChange;
  final Function(Item)? onDelete;

  @override
  State<ForTradeTile> createState() => _ForTradeTile();
}

class _ForTradeTile extends State<ForTradeTile> {
  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);

    return Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ForTradeDetailsPage(
                  pokemons: widget.pokemons,
                  indexes: widget.indexes,
                  onStateChange: widget.onStateChange,
                );
              },
            ),
          ),
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
