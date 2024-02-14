// import 'package:flutter/material.dart';
// import 'package:oaks_legacy/components/action_button.dart';
// import 'package:oaks_legacy/components/basic.dart';
// import 'package:oaks_legacy/constants.dart';
// import 'package:oaks_legacy/models/enums.dart';
// import 'package:oaks_legacy/models/game.dart';
// import '../components/app_bar_details.dart';
// import '../models/tab.dart';
// import '../components/type_background.dart';
// import '../components/image.dart';
// import '../components/details_panel.dart';
// import '../models/pokemon.dart';

// class PokedexDetailsPageV3 extends StatefulWidget {
//   const PokedexDetailsPageV3(
//       {super.key, required this.pokemons, required this.indexes});

//   final List<Pokemon> pokemons;
//   final List<int> indexes;

//   @override
//   State<PokedexDetailsPageV3> createState() => _PokedexDetailsPageV3();
// }

// class _PokedexDetailsPageV3 extends State<PokedexDetailsPageV3> {
//   int imageIndex = 0;
//   bool isFirstInList = false;
//   bool isLastInList = false;
//   List<int> currentIndexes = List<int>.empty(growable: true);

//   @override
//   void initState() {
//     currentIndexes.addAll(widget.indexes);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     isFirstInList = widget.pokemons.isFirst(currentIndexes);
//     isLastInList = widget.pokemons.isLast(currentIndexes);

//     Pokemon pokemon = widget.pokemons.current(currentIndexes);
//     bool isMobile = MediaQuery.of(context).size.width < 1024;
//     return Stack(
//       children: [
//         TypeBackground(type1: pokemon.type1, type2: pokemon.type2),
//         Expanded(
//           child: Center(
//             child: GridView.count(
//               crossAxisCount: 3,
//               childAspectRatio: 1.3,
//               children: <Widget>[
//                 Expanded(
//                   child: Column(
//                     children: [
//                       DetailsAppBar(
//                         name: pokemon.name,
//                         number: pokemon.number,
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Image.network(
//                             '${kImageLocalPrefix}mons/${pokemon.image[imageIndex]}',
//                           ),
//                         ),
//                       ),
//                       createButtons(pokemon),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     BaseDetailsBlock(pokemon: pokemon),
//                     BreedingBlock(pokemon: pokemon),
//                   ],
//                 ),
//                 GamesBlock(pokemon: pokemon),
//                 WeaknessBlock(pokemon: pokemon),
//                 const DetailsCard(
//                     cardChild: Expanded(
//                       child: Center(
//                         child: Icon(
//                           Icons.not_interested_outlined,
//                           size: 150,
//                           color: Colors.blueGrey,
//                         ),
//                       ),
//                     ),
//                     blockTitle: "Stats"),
//                 const DetailsCard(
//                     cardChild: Expanded(
//                       child: Center(
//                         child: Icon(
//                           Icons.not_interested_outlined,
//                           size: 150,
//                           color: Colors.blueGrey,
//                         ),
//                       ),
//                     ),
//                     blockTitle: "Stats 2"),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );

//     return Scaffold(
//       body: Stack(
//         children: [
//           TypeBackground(type1: pokemon.type1, type2: pokemon.type2),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     //Main Block
//                     Expanded(
//                       child: Column(
//                         children: [
//                           DetailsAppBar(
//                             name: pokemon.name,
//                             number: pokemon.number,
//                           ),
//                           Expanded(
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: Image.network(
//                                 '${kImageLocalPrefix}mons/${pokemon.image[imageIndex]}',
//                               ),
//                             ),
//                           ),
//                           createButtons(pokemon),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           BaseDetailsBlock(pokemon: pokemon),
//                           BreedingBlock(pokemon: pokemon)
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     //Main Block
//                     GamesBlock(pokemon: pokemon),
//                     WeaknessBlock(pokemon: pokemon),
//                   ],
//                 ),
//               ),
//               const Expanded(
//                 child: Column(
//                   children: [
//                     DetailsCard(
//                         cardChild: Expanded(
//                           child: Center(
//                             child: Icon(
//                               Icons.not_interested_outlined,
//                               size: 150,
//                               color: Colors.blueGrey,
//                             ),
//                           ),
//                         ),
//                         blockTitle: "Stats"),
//                     DetailsCard(
//                         cardChild: Expanded(
//                           child: Center(
//                             child: Icon(
//                               Icons.not_interested_outlined,
//                               size: 150,
//                               color: Colors.blueGrey,
//                             ),
//                             // child: Text(
//                             //   "[Soon]",
//                             //   style: TextStyle(
//                             //     color: Colors.redAccent,
//                             //     fontSize: 30,
//                             //     fontStyle: FontStyle.italic,
//                             //   ),
//                             // ),
//                           ),
//                         ),
//                         blockTitle: "Stats"),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget createButtons(Pokemon pokemon) {
//     Widget imageButtons = Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (pokemon.imageHasGenderAlter())
//           //FEMALE VERSION
//           ActionButton(
//             onPress: () => {
//               setState(() {
//                 imageIndex =
//                     pokemon.findImageIndexByGender(PokemonGender.female);
//               }),
//             },
//             icon: (pokemon.imageGender() == PokemonGender.female)
//                 ? const Icon(Icons.female, color: Colors.red)
//                 : const Icon(Icons.female, color: Colors.grey),
//           ),

//         //SHINY VARIANT
//         ActionButton(
//           onPress: () => {
//             setState(() {
//               (pokemon.imageVariant() == PokemonVariant.normal)
//                   ? imageIndex =
//                       pokemon.findImageIndexByVariant(PokemonVariant.shiny)
//                   : imageIndex =
//                       pokemon.findImageIndexByVariant(PokemonVariant.normal);
//             }),
//           },
//           icon: (pokemon.imageVariant() == PokemonVariant.normal)
//               ? Image.network(
//                   '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
//                   color: Colors.grey,
//                   height: 20,
//                   width: 24,
//                 )
//               : Image.network(
//                   '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
//                   color: Colors.amber,
//                   height: 20,
//                   width: 24,
//                 ),
//         ),

//         if (pokemon.imageHasGenderAlter())
//           //MALE VERSION
//           ActionButton(
//             onPress: () => {
//               setState(() {
//                 imageIndex = pokemon.findImageIndexByGender(PokemonGender.male);
//               }),
//             },
//             icon: (pokemon.imageGender() == PokemonGender.male)
//                 ? const Icon(Icons.male, color: Colors.blue)
//                 : const Icon(Icons.male, color: Colors.grey),
//           ),
//       ],
//     );

//     Widget paginationButtons = Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         //Go LEFT
//         ActionButton(
//           onPress: (isFirstInList)
//               ? null
//               : () => {
//                     setState(() {
//                       imageIndex = 0;
//                       pokemon.resetImage();
//                       currentIndexes =
//                           widget.pokemons.previousIndex(currentIndexes);
//                     }),
//                   },
//           icon: const Icon(
//             Icons.arrow_circle_left_outlined,
//             color: Colors.white,
//           ),
//         ),
//         imageButtons,
//         //GO RIGHT
//         ActionButton(
//           onPress: (isLastInList)
//               ? null
//               : () => {
//                     setState(() {
//                       imageIndex = 0;
//                       pokemon.resetImage();
//                       currentIndexes =
//                           widget.pokemons.nextIndex(currentIndexes);
//                     }),
//                   },
//           icon: const Icon(
//             Icons.arrow_circle_right_outlined,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );

//     return paginationButtons;
//   }

//   buildTab(Pokemon pokemon) {
//     List<PokeTabv2> tabs = [];
//     tabs.addAll([
//       PokeTabv2(
//         tabName: "Base",
//         tabContent: BaseDetailsBlock(pokemon: pokemon),
//       ),
//       PokeTabv2(
//         tabName: "Breed",
//         tabContent: BreedingBlock(pokemon: pokemon),
//       ),
//       PokeTabv2(
//         tabName: "Games",
//         tabContent: GamesBlock(pokemon: pokemon),
//       ),
//       PokeTabv2(
//         tabName: "Weak",
//         tabContent: WeaknessBlock(pokemon: pokemon),
//       ),
//     ]);

//     return tabs;
//   }
// }

// class BaseDetailsBlock extends StatelessWidget {
//   const BaseDetailsBlock({
//     super.key,
//     required this.pokemon,
//   });

//   final Pokemon pokemon;

//   @override
//   Widget build(BuildContext context) {
//     Widget mainContent = Card(
//       color: Colors.black12,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "The ${pokemon.species}",
//             textAlign: TextAlign.center,
//             softWrap: true,
//             style: const TextStyle(color: Colors.white, fontSize: 30),
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   textAlign: TextAlign.center,
//                   softWrap: true,
//                   "#${pokemon.number}",
//                   style: const TextStyle(color: Colors.white, fontSize: 30),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TypeIconBox(type: pokemon.type1),
//                     if (pokemon.type2 != null)
//                       const Padding(
//                         padding: EdgeInsets.only(bottom: 5),
//                         child: FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Text(
//                             "·",
//                             style: TextStyle(color: Colors.white, fontSize: 50),
//                           ),
//                         ),
//                       ),
//                     if (pokemon.type2 != null)
//                       TypeIconBox(type: pokemon.type2!),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SimpleBox(textTitle: "Height", textValue: pokemon.height),
//                 SimpleBox(textTitle: "Weight", textValue: pokemon.weight),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

//     return (MediaQuery.of(context).size.width < 1024)
//         ? mainContent
//         : DetailsCard(
//             cardChild: Expanded(child: mainContent),
//             blockTitle: "Base Details");
//   }
// }

// class BreedingBlock extends StatelessWidget {
//   const BreedingBlock({
//     super.key,
//     required this.pokemon,
//   });

//   final Pokemon pokemon;

//   @override
//   Widget build(BuildContext context) {
//     Widget mainContent = Column(
//       children: [
//         Expanded(
//           child: Card(
//             color: Colors.black12,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ImageTextBox(
//                   image: const Icon(
//                     Icons.male,
//                     color: Colors.blueAccent,
//                     size: 30,
//                   ),
//                   text: '${pokemon.genderRatio.male}%',
//                 ),
//                 ImageTextBox(
//                   image: const Icon(
//                     Icons.female,
//                     color: Colors.redAccent,
//                     size: 30,
//                   ),
//                   text: '${pokemon.genderRatio.female}%',
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Card(
//                   color: Colors.black12,
//                   child: SimpleBox2(
//                     textTitle: 'cycles ${pokemon.breeding.getSteps()}',
//                     textValue: pokemon.breeding.cycles,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Card(
//                   color: Colors.black12,
//                   child: SimpleBox2(
//                     textTitle: 'Egg Groups',
//                     textValue: pokemon.breeding.groups.toString(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );

//     return (MediaQuery.of(context).size.width < 1024)
//         ? mainContent
//         : DetailsCard(
//             cardChild: Expanded(child: mainContent), blockTitle: "Breeding");
//   }
// }

// class GamesBlock extends StatelessWidget {
//   const GamesBlock({
//     super.key,
//     required this.pokemon,
//   });

//   final Pokemon pokemon;

//   @override
//   Widget build(BuildContext context) {
//     Widget mainContent = Card(
//       color: Colors.black12,
//       child: SingleChildScrollView(
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index2) {
//             return ListTile(
//               // tileColor: Colors.black,
//               leading: ListImage(
//                 image: Game.gameIcon(pokemon.games[index2].name),
//               ),
//               title: Text(
//                 pokemon.games[index2].name,
//                 style: const TextStyle(color: Colors.white, fontSize: 15),
//               ),
//               subtitle: Text(
//                 '(${pokemon.games[index2].dex})',
//                 style: const TextStyle(
//                   color: Colors.amber,
//                 ),
//               ),
//               trailing: Text(
//                 (pokemon.games[index2].number == "")
//                     ? ""
//                     : '#${pokemon.games[index2].number}',
//                 style: const TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             );
//           },
//           itemCount: pokemon.games.length,
//           padding: const EdgeInsets.all(5),
//           scrollDirection: Axis.vertical,
//         ),
//       ),
//     );
//     return (MediaQuery.of(context).size.width < 1024)
//         ? mainContent
//         : DetailsCard(
//             cardChild: Expanded(child: mainContent), blockTitle: "Games");
//   }
// }

// class WeaknessBlock extends StatelessWidget {
//   const WeaknessBlock({
//     super.key,
//     required this.pokemon,
//   });

//   final Pokemon pokemon;

//   @override
//   Widget build(BuildContext context) {
//     double iconSize = (MediaQuery.of(context).size.width < 1024)
//         ? 25
//         : MediaQuery.of(context).size.width / 35;
//     Widget mainContent = Column(
//       children: [
//         Expanded(
//           child: Row(
//             children: [
//               Weak(
//                 text: "x ¼",
//                 list: pokemon.weakness.quarter,
//                 size: iconSize,
//               ),
//               Weak(
//                 text: "x ½",
//                 list: pokemon.weakness.half,
//                 size: iconSize,
//               ),
//             ],
//           ),
//         ),
//         Weak(
//           text: "x 0",
//           list: pokemon.weakness.none,
//           size: iconSize,
//         ),
//         Expanded(
//           child: Row(
//             children: [
//               Weak(
//                 text: "x 2",
//                 list: pokemon.weakness.double,
//                 size: iconSize,
//               ),
//               Weak(
//                 text: "x 4",
//                 list: pokemon.weakness.quadruple,
//                 size: iconSize,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//     return (MediaQuery.of(context).size.width < 1024)
//         ? mainContent
//         : DetailsCard(
//             cardChild: Expanded(child: mainContent), blockTitle: "Weakness");
//   }
// }

// class Weak extends StatelessWidget {
//   const Weak({
//     super.key,
//     required this.text,
//     required this.list,
//     required this.size,
//   });

//   final String text;
//   final List<dynamic> list;
//   final double size;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Card(
//         color: Colors.black12,
//         child: Column(
//           children: [
//             SubTextDivider(text: text),
//             Expanded(
//               child: Center(
//                 child: Wrap(
//                   direction: Axis.horizontal,
//                   alignment: WrapAlignment.center,
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   children: list
//                       .map(
//                         (i) => Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: Pokemon.typeImage(
//                             PokemonType.values.byName(i),
//                             size: size,
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TypeIconBox extends StatelessWidget {
//   const TypeIconBox({
//     super.key,
//     required this.type,
//   });

//   final PokemonType type;

//   @override
//   Widget build(BuildContext context) {
//     double iconSize = MediaQuery.of(context).size.width / 30;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: iconSize,
//           child: Padding(
//             padding: const EdgeInsets.all(5),
//             child: Pokemon.typeImage(type),
//           ),
//         ),
//         Text(
//           type.name.toUpperCase(),
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         )
//       ],
//     );
//   }
// }

// class SimpleBox extends StatelessWidget {
//   const SimpleBox({
//     super.key,
//     required this.textTitle,
//     required this.textValue,
//   });

//   final String textTitle;
//   final String textValue;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text(
//                 textValue,
//                 style: const TextStyle(color: Colors.white, fontSize: 35),
//               ),
//             ),
//             FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text(
//                 textTitle,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SimpleBox2 extends StatelessWidget {
//   const SimpleBox2({
//     super.key,
//     required this.textTitle,
//     required this.textValue,
//   });

//   final String textTitle;
//   final String textValue;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             textValue,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 25,
//             ),
//           ),
//           Text(
//             textTitle,
//             textAlign: TextAlign.center,
//             softWrap: true,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 15,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ImageTextBox extends StatelessWidget {
//   const ImageTextBox({
//     super.key,
//     required this.image,
//     required this.text,
//   });

//   final Widget image;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 30,
//             ),
//           ),
//           image,
//         ],
//       ),
//     );
//   }
// }
