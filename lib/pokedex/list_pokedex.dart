// import 'package:flutter/material.dart';
// import 'package:oaks_legacy/components/pkm_grid.dart';
// import '/models/game.dart';
// import '/models/item.dart';
// import '/models/pokemon.dart';
// import '/pokedex/pokedex_tiles.dart';

// class PokedexList extends StatefulWidget {
//   const PokedexList({
//     super.key,
//     required this.pokemons,
//     this.detailsKey,
//     this.pageBuilder,
//     this.button1Icon,
//     this.button1OnPressed,
//     this.button2Icon,
//     this.button2OnPressed,
//   });

//   final List<Pokemon> pokemons;
//   final String? detailsKey;
//   final Widget Function(List<Item> items, List<int> indexes)? pageBuilder;
//   final Icon? button1Icon;
//   final Function(Pokemon)? button1OnPressed;
//   final Icon? button2Icon;
//   final Function(Pokemon)? button2OnPressed;

//   @override
//   State<PokedexList> createState() => _PokedexListState();
// }

// class _PokedexListState extends State<PokedexList> {
//   @override
//   build(BuildContext context) {
//     return PkmGrid(
//       itemCount: widget.pokemons.length,
//       itemBuilder: (context, index) {
//         return PokemonTiles(
//           isLowerTile: false,
//           // pokemons: widget.pokemons.take(data.length).toList(),
//           pokemons: widget.pokemons,
//           indexes: [index],
//           onTapOverride: (widget.pageBuilder != null)
//               ? (indexes) {
//                   setState(() {
//                     List<Item> items = [
//                       createPlaceholderItem(
//                           indexes, widget.detailsKey!, widget.pokemons)
//                     ];
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return widget.pageBuilder!(items, [0]);
//                         },
//                       ),
//                     );
//                   });
//                 }
//               : null,
//           button1Icon: widget.button1Icon,
//           button1OnPressed: widget.button1OnPressed,
//           button2Icon: widget.button2Icon,
//           button2OnPressed: widget.button2OnPressed,
//         );
//       },
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


// //  When using the lazy loading from TestScreen 6, this is the Widget:
// // child: Column(
// //   children: [
// //     Expanded(
// //       child: SingleChildScrollView(
// //         controller: scrollController,
// //         child: Wrap(
// //           spacing: 5,
// //           runSpacing: 5,
// //           alignment: WrapAlignment.center,
// //           children: data.map((index) {
// //             return PokemonTiles(
// //               isLowerTile: false,
// //               pokemons: widget.pokemons.take(data.length).toList(),
// //               indexes: [index],
// //               onStateChange: (widget.pageBuilder != null)
// //                   ? (indexes) {
// //                       setState(() {
// //                         List<Item> items = [
// //                           createPlaceholderItem(indexes,
// //                               widget.detailsKey!, widget.pokemons)
// //                         ];
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) {
// //                               return widget.pageBuilder!(items, [0]);
// //                             },
// //                           ),
// //                         );
// //                       });
// //                     }
// //                   : null,
// //             );
// //           }).toList(),
// //         ),
// //       ),
// //     ),
// //   ],
// // ),