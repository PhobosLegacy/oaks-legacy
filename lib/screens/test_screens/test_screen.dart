// import 'package:flutter/material.dart';
// import 'package:oaks_legacy/components/app_bar.dart';
// import 'package:oaks_legacy/components/base_background.dart';
// import 'package:oaks_legacy/components/image.dart';
// import 'package:oaks_legacy/constants.dart';
// import 'package:oaks_legacy/models/pokemon.dart';

// //WRAP + POKETILE + LAZY LOADING
// class TestListScreen extends StatefulWidget {
//   const TestListScreen({
//     super.key,
//   });

//   @override
//   State<TestListScreen> createState() => _TestListScreenState();
// }

// class _TestListScreenState extends State<TestListScreen> {
//   ScrollController _scrollController = ScrollController();
//   List<int> _data = List.generate(42, (index) => index);

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_loadMoreItems);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _loadMoreItems() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       // Load more items when scrolled to the end
//       setState(() {
//         _data.addAll(List.generate(10, (index) => _data.length + index));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBarBase(
//         title: const Text(
//           "Test",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         actions: null,
//         color: Colors.blueGrey[800],
//       ),
//       body: Stack(
//         children: [
//           const BaseBackground(),
//           SafeArea(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     controller: _scrollController,
//                     child: Wrap(
//                       spacing: 8.0,
//                       children: _data.map((index) {
//                         return SizedBox(
//                           width: MediaQuery.of(context).size.width / 6 - 12.0,
//                           child: PokemonTiles(
//                             isLowerTile: false,
//                             pokemons: kPokedex,
//                             indexes: [index],
//                             onStateChange: null,
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PokemonTiles extends StatefulWidget {
//   const PokemonTiles({
//     super.key,
//     required this.pokemons,
//     required this.indexes,
//     required this.isLowerTile,
//     this.onStateChange,
//   });

//   final bool isLowerTile;
//   final List<Pokemon> pokemons;
//   final List<int> indexes;
//   final Function(List<int>)? onStateChange;

//   @override
//   State<PokemonTiles> createState() => _PokemonTiles();
// }

// class _PokemonTiles extends State<PokemonTiles> {
//   @override
//   Widget build(BuildContext context) {
//     Pokemon pokemon = widget.pokemons.current(widget.indexes);

//     return Card(
//       clipBehavior: Clip.antiAlias,
//       child: ExpansionTile(
//         trailing: const SizedBox(),
//         // subtitle: Text(
//         //   "Icaro",
//         //   style: TextStyle(fontSize: 20),
//         // ),
//         title: FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Row(
//             children: [
//               Hero(
//                 tag: pokemon.ref,
//                 child: SizedBox(
//                     child: ListImage(image: 'mons/${pokemon.image[0]}')),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: Center(
//                       child: Text(
//                         (pokemon.formName == "")
//                             ? pokemon.name
//                             : pokemon.formName,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 30),
//                       ),
//                     ),
//                   ),
//                   FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: Text(
//                       "#${pokemon.number}",
//                       style: const TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         height: 50,
//                         child: Pokemon.typeImage(pokemon.type1),
//                       ),
//                       if (pokemon.type2 != null)
//                         const FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Text(
//                             "·",
//                             style: TextStyle(color: Colors.white, fontSize: 50),
//                           ),
//                         ),
//                       if (pokemon.type2 != null)
//                         SizedBox(
//                           height: 50,
//                           child: Pokemon.typeImage(pokemon.type2),
//                         ),
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//         backgroundColor: Colors.lightGreen,
//         collapsedBackgroundColor:
//             (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,

//         children: [if (pokemon.forms.isNotEmpty) ...createChildren()],
//         // children: const [
//         //   ListTile(title: Text('This is tile number ')),
//         //   ListTile(title: Text('This is tile number ')),
//         //   ListTile(title: Text('This is tile number ')),
//         //   ListTile(title: Text('This is tile number ')),
//         //   ListTile(title: Text('This is tile number ')),
//         //   ListTile(title: Text('This is tile number ')),
//         //   ListTile(title: Text('This is tile number ')),
//         //   ListTile(title: Text('This is tile number ')),
//         // ],
//       ),
//     );

//     // var stack = GestureDetector(
//     //   onTap: (widget.onStateChange == null)
//     //       ? () => {
//     //             Navigator.push(
//     //               context,
//     //               MaterialPageRoute(
//     //                 builder: (context) {
//     //                   return PokedexDetailsPage(
//     //                     pokemons: widget.pokemons,
//     //                     indexes: widget.indexes,
//     //                   );
//     //                 },
//     //               ),
//     //             )
//     //           }
//     //       : () {
//     //           widget.onStateChange!(widget.indexes);
//     //         },
//     //   child: Card(
//     //     color: (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
//     //     clipBehavior: Clip.antiAlias,
//     //     child: Column(
//     //       mainAxisSize: MainAxisSize.min,
//     //       children: [
//     //         Expanded(
//     //             flex: 10,
//     //             child: Row(
//     //               children: [
//     //                 Hero(
//     //                   tag: pokemon.ref,
//     //                   child: ListImage(image: 'mons/${pokemon.image[0]}'),
//     //                 ),
//     //                 Expanded(
//     //                   child: Column(
//     //                     children: [
//     //                       //NAME
//     //                       Expanded(
//     //                         child: FittedBox(
//     //                           fit: BoxFit.scaleDown,
//     //                           child: Center(
//     //                             child: Text(
//     //                               (pokemon.formName == "")
//     //                                   ? pokemon.name
//     //                                   : pokemon.formName,
//     //                               style: const TextStyle(
//     //                                   fontWeight: FontWeight.bold,
//     //                                   color: Colors.white,
//     //                                   fontSize: 30),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                       ),
//     //                       //NUMBER
//     //                       Expanded(
//     //                         child: Row(
//     //                           mainAxisAlignment: MainAxisAlignment.center,
//     //                           children: [
//     //                             FittedBox(
//     //                               fit: BoxFit.scaleDown,
//     //                               child: Text(
//     //                                 "#${pokemon.number}",
//     //                                 style: const TextStyle(
//     //                                     fontSize: 25,
//     //                                     fontWeight: FontWeight.bold,
//     //                                     color: Colors.white),
//     //                               ),
//     //                             ),
//     //                             const SizedBox(width: 36),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                       //TYPE
//     //                       Expanded(
//     //                         child: Row(
//     //                           mainAxisAlignment: MainAxisAlignment.center,
//     //                           crossAxisAlignment: CrossAxisAlignment.center,
//     //                           children: [
//     //                             SizedBox(
//     //                               child: Padding(
//     //                                   padding: const EdgeInsets.only(bottom: 5),
//     //                                   child: Pokemon.typeImage(pokemon.type1)),
//     //                             ),
//     //                             if (pokemon.type2 != null)
//     //                               const Padding(
//     //                                 padding: EdgeInsets.only(bottom: 5),
//     //                                 child: FittedBox(
//     //                                   fit: BoxFit.scaleDown,
//     //                                   child: Text(
//     //                                     "·",
//     //                                     style: TextStyle(
//     //                                         color: Colors.white, fontSize: 50),
//     //                                   ),
//     //                                 ),
//     //                               ),
//     //                             if (pokemon.type2 != null)
//     //                               SizedBox(
//     //                                 child: Padding(
//     //                                   padding: const EdgeInsets.only(bottom: 5),
//     //                                   child: Pokemon.typeImage(pokemon.type2),
//     //                                 ),
//     //                               ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ],
//     //             )),
//     //         //FORMS
//     //         Row(
//     //           mainAxisAlignment: MainAxisAlignment.center,
//     //           children: [
//     //             if (pokemon.forms.isNotEmpty)
//     //               const Icon(
//     //                 Icons.keyboard_arrow_down_outlined,
//     //                 // Icons.keyboard_double_arrow_down,
//     //                 color: Colors.white,
//     //               ),
//     //             Text(
//     //               (pokemon.forms.isNotEmpty)
//     //                   ? '+${pokemon.forms.length - 1}'
//     //                   : "",
//     //               style: const TextStyle(
//     //                 color: Colors.white,
//     //                 fontSize: 15,
//     //                 fontStyle: FontStyle.italic,
//     //               ),
//     //             ),
//     //           ],
//     //         )
//     //       ],
//     //     ),
//     //   ),
//     // );

//     // return stack;

//     // MOBILE FRIENDLY
//     // return Card(
//     //   child: ListTile(
//     //     tileColor: (widget.isLowerTile) ? null : Colors.black26,
//     //     textColor: Colors.black,
//     //     onTap: (widget.onStateChange == null)
//     //         ? () => {
//     //               Navigator.push(
//     //                 context,
//     //                 MaterialPageRoute(
//     //                   builder: (context) {
//     //                     return PokedexDetailsPage(
//     //                       pokemons: widget.pokemons,
//     //                       indexes: widget.indexes,
//     //                     );
//     //                   },
//     //                 ),
//     //               )
//     //             }
//     //         : () {
//     //             widget.onStateChange!(widget.indexes);
//     //           },
//     //     leading: Hero(
//     //       tag: pokemon.ref,
//     //       child: ListImage(image: 'mons/${pokemon.image[0]}'),
//     //     ),
//     //     title: Row(
//     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       children: [
//     //         Flexible(
//     //           fit: FlexFit.loose,
//     //           child: Text(
//     //             //pokemon.name + " (" + pokemon.formName + ")",
//     //             (pokemon.formName == "") ? pokemon.name : pokemon.formName,
//     //             style: const TextStyle(fontWeight: FontWeight.bold),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //     subtitle: Row(
//     //       children: [
//     //         SizedBox(
//     //           height: 20,
//     //           child: Pokemon.typeImage(pokemon.type1),
//     //         ),
//     //         if (pokemon.type2 != null) const Text("·"),
//     //         if (pokemon.type2 != null)
//     //           SizedBox(
//     //             height: 20,
//     //             child: Pokemon.typeImage(pokemon.type2),
//     //           ),
//     //       ],
//     //     ),
//     //     trailing: (!widget.isLowerTile)
//     //         ? Row(
//     //             mainAxisSize: MainAxisSize.min,
//     //             children: [
//     //               Text(
//     //                 "#${pokemon.number}",
//     //                 style: const TextStyle(
//     //                     fontSize: 15, fontWeight: FontWeight.bold),
//     //               ),
//     //               const SizedBox(width: 36),
//     //             ],
//     //           )
//     //         : null,
//     //   ),
//     // );
//   }

//   List<Widget> createChildren() {
//     Pokemon pokemon = widget.pokemons.current(widget.indexes);
//     List<PokemonTiles> tiles = [];

//     for (var i = 0; i < pokemon.forms.length; i++) {
//       tiles.add(PokemonTiles(
//           pokemons: widget.pokemons,
//           indexes: [...widget.indexes, i],
//           isLowerTile: true));
//     }
//     return tiles;
//   }
// }
