import 'package:flutter/material.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/tracker/tracker_tiles.dart';
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
  final Icon? button1Icon;
  final Function(Pokemon)? button1OnPressed;
  final Icon? button2Icon;
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
        child: Center(
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
      ),
    ]);
  }
}

class ShowItemForms extends StatelessWidget {
  const ShowItemForms({
    super.key,
    required this.pokemons,
    required this.indexes,
    required this.isLowerTile,
    this.onStateChange,
  });

  final bool isLowerTile;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function()? onStateChange;

  @override
  Widget build(BuildContext context) {
    Item pokemon = pokemons.current(indexes);

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
                return TrackerTile(
                  isLowerTile: isLowerTile,
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

class ShowOptions extends StatelessWidget {
  const ShowOptions({
    super.key,
    // this.onOptionSelected,
    required this.items,
  });

  // final Function(dynamic)? onOptionSelected;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 400;

    Widget children = Center(
      child: Wrap(
        spacing: 50,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: items,
      ),
    );

    children = (isSmallScreen)
        ? SingleChildScrollView(
            child: children,
          )
        : children;

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
      Expanded(child: children)
    ]);
  }
}
