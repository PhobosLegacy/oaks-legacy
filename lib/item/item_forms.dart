import 'package:flutter/material.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/tracker/tracker_tiles.dart';

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
