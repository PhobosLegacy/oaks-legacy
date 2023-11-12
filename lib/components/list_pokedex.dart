import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/game.dart';
import 'package:proto_dex/models/item.dart';
import 'package:proto_dex/models/pokemon.dart';
import 'package:proto_dex/pokedex/pokedex_cards.dart';

class PokedexList extends StatefulWidget {
  const PokedexList({
    super.key,
    this.detailsKey,
    this.pageBuilder,
  });

  final String? detailsKey;
  final Widget Function(List<Item> items, List<int> indexes)? pageBuilder;

  @override
  State<PokedexList> createState() => _PokedexListState();
}

class _PokedexListState extends State<PokedexList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return createCards(
          kPokedex,
          [index],
          onStateChange: (widget.pageBuilder != null)
              ? (indexes) {
                  setState(() {
                    List<Item> items = [
                      createPlaceholderItem(indexes, widget.detailsKey!)
                    ];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return widget.pageBuilder!(items, [0]);
                        },
                      ),
                    );
                  });
                }
              : null,
        );
      }),
      itemCount: kPokedex.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
    );
  }
}

Item createPlaceholderItem(List<int> indexes, String origin) {
  Pokemon pokemon = kPokedex.current(indexes);
  Game tempGame =
      Game(name: "Unknown", dex: "", number: "", notes: "", shinyLocked: "");
  Item item = Item.fromDex(pokemon, tempGame, origin);
  item.currentLocation = "Unknown";
  item.catchDate = DateTime.now().toString();
  return item;
}
