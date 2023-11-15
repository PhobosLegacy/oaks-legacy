import 'package:flutter/material.dart';
import 'package:oaks_legacy/pokedex/pokedex_tiles.dart';
import '../components/image.dart';
import '../models/pokemon.dart';

Widget createCards(
  List<Pokemon> pokemons,
  List<int> indexes, {
  Function(List<int>)? onStateChange,
  isLowerTile = false,
}) {
  final GlobalKey expansionTileKey = GlobalKey();

  Pokemon pokemon = pokemons.current(indexes);

  if (pokemon.forms.isEmpty) {
    return PokemonTiles(
      isLowerTile: isLowerTile,
      pokemons: pokemons,
      indexes: indexes,
      onStateChange: onStateChange,
    );
  }

  void scrollToPokemon({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 240)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  return Card(
    child: ExpansionTile(
      key: expansionTileKey,
      onExpansionChanged: (value) {
        if (value) {
          scrollToPokemon(expansionTileKey: expansionTileKey);
        }
      },
      textColor: Colors.black,
      collapsedTextColor: Colors.black,
      collapsedBackgroundColor: (isLowerTile) ? null : Colors.black26,
      backgroundColor: (isLowerTile) ? Colors.black12 : Colors.black26,
      leading: ListImage(
        image: "mons/${pokemon.image[0]}",
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pokemon.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          SizedBox(
            height: 20,
            child: Pokemon.typeImage(pokemon.type1),
          ),
          if (pokemon.type2 != null) const Text("·"),
          if (pokemon.type2 != null)
            SizedBox(
              height: 20,
              child: Pokemon.typeImage(pokemon.type2),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isLowerTile)
            Text(
              "#${pokemon.number}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                '+${pokemon.forms.length - 1}',
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return createCards(pokemons, [...indexes, index2],
                onStateChange: onStateChange, isLowerTile: true);
          },
          itemCount: pokemon.forms.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
      ],
    ),
  );
}
