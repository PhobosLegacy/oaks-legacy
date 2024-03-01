import 'package:flutter/material.dart';
import 'package:oaks_legacy/tracker/tracker_tiles.dart';
import '/models/game.dart';
import '/models/item.dart';
import '/models/pokemon.dart';

class ItemList extends StatefulWidget {
  const ItemList({
    super.key,
    required this.pokemons,
    required this.callBackAction,
    this.pageBuilder,
  });

  final List<Item> pokemons;
  final VoidCallback callBackAction;
  final Widget Function(List<Item> items, List<int> indexes)? pageBuilder;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    int cardsPerRow = currentWidth ~/ 400;
    if (cardsPerRow == 0) cardsPerRow = 1;

    return Expanded(
      child: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            // Adjust the cross axis count as needed
            crossAxisCount: cardsPerRow,
            // Adjust the height here
            childAspectRatio: (cardsPerRow == 1) ? 3 : 2,
          ),
          itemCount: widget.pokemons.length,
          itemBuilder: (context, index) {
            return TrackerTile(
              pokemons: widget.pokemons,
              indexes: [index],
              isLowerTile: false,
              onStateChange: () {
                widget.callBackAction();
              },
            );
          },
        ),
      ),
    );
  }
}

//This makes sure that when you click on one of the Pokedex list pokemon, it converts to an Item so it can be added to any collection
Item createPlaceholderItem(
    List<int> indexes, String origin, List<Pokemon> pokemons) {
  Pokemon pokemon = pokemons.current(indexes);
  Game tempGame =
      Game(name: "Unknown", dex: "", number: "", notes: "", shinyLocked: "");
  Item item = Item.fromDex(pokemon, tempGame, origin);
  item.currentLocation = "Unknown";
  item.catchDate = DateTime.now().toString();
  return item;
}
