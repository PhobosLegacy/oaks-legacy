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
    this.button1Icon,
    this.button1OnPressed,
    this.button2Icon,
    this.button2OnPressed,
  });

  final bool isLowerTile;
  final List<Pokemon> pokemons;
  final List<int> indexes;
  final Function(List<int>)? onStateChange;
  final Widget? button1Icon;
  final Function(Pokemon)? button1OnPressed;
  final Widget? button2Icon;
  final Function(Pokemon)? button2OnPressed;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose a ${pokemon.name} Variant',
              style: const TextStyle(color: Colors.amber, fontSize: 30),
            ),
            Center(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  alignment: WrapAlignment.center,
                  children: pokemon.forms.map((form) {
                    final index = pokemon.forms.indexOf(form);
                    return PokemonTiles(
                      isLowerTile: isLowerTile,
                      pokemons: pokemons,
                      indexes: [...indexes, index],
                      onTapOverride: onStateChange,
                      button1Icon: button1Icon,
                      button1OnPressed: button1OnPressed,
                      button2Icon: button2Icon,
                      button2OnPressed: button2OnPressed,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
