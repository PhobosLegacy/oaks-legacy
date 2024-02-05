import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import 'pokedex_tiles.dart';

class ShowForms extends StatelessWidget {
  const ShowForms({
    super.key,
    required this.pokemons,
    required this.indexes,
    required this.isLowerTile,
    this.onStateChange,
  });

  final bool isLowerTile;
  final List<Pokemon> pokemons;
  final List<int> indexes;
  final Function(List<int>)? onStateChange;

  @override
  Widget build(BuildContext context) {
    Pokemon pokemon = pokemons.current(indexes);

    return Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          iconSize: 50,
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ),
      Expanded(
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.center,
              children: pokemon.forms.map((form) {
                final index = pokemon.forms.indexOf(form);
                return PokemonTiles(
                  isLowerTile: true,
                  pokemons: pokemons,
                  indexes: [...indexes, index],
                  onStateChange: onStateChange,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ]);
  }
}
