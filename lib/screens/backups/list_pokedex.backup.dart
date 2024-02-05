// import 'package:flutter/material.dart';
// import 'package:oaks_legacy/models/game.dart';
// import 'package:oaks_legacy/models/item.dart';
// import 'package:oaks_legacy/models/pokemon.dart';
// import 'package:oaks_legacy/pokedex/pokedex_cards.dart';

// class PokedexList extends StatefulWidget {
//   const PokedexList({
//     super.key,
//     required this.pokemons,
//     this.detailsKey,
//     this.pageBuilder,
//   });

//   final List<Pokemon> pokemons;
//   final String? detailsKey;
//   final Widget Function(List<Item> items, List<int> indexes)? pageBuilder;

//   @override
//   State<PokedexList> createState() => _PokedexListState();
// }

// class _PokedexListState extends State<PokedexList> {
//   @override
//   build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemBuilder: ((context, index) {
//           return createCards(
//             widget.pokemons,
//             [index],
//             onStateChange: (widget.pageBuilder != null)
//                 ? (indexes) {
//                     setState(() {
//                       List<Item> items = [
//                         createPlaceholderItem(
//                             indexes, widget.detailsKey!, widget.pokemons)
//                       ];
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return widget.pageBuilder!(items, [0]);
//                           },
//                         ),
//                       );
//                     });
//                   }
//                 : null,
//           );
//         }),
//         itemCount: widget.pokemons.length,
//         shrinkWrap: true,
//         padding: const EdgeInsets.all(5),
//         scrollDirection: Axis.vertical,
//       ),
//     );
//   }
// }

// //This makes sure that when you click on one of the Pokedex list pokemon, it converts to an Item so it can be added to any collection
// Item createPlaceholderItem(
//     List<int> indexes, String origin, List<Pokemon> pokemons) {
//   Pokemon pokemon = pokemons.current(indexes);
//   Game tempGame =
//       Game(name: "Unknown", dex: "", number: "", notes: "", shinyLocked: "");
//   Item item = Item.fromDex(pokemon, tempGame, origin);
//   item.currentLocation = "Unknown";
//   item.catchDate = DateTime.now().toString();
//   return item;
// }
