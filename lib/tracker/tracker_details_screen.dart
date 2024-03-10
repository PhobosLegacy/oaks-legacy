import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/action_button.dart';
import 'package:oaks_legacy/components/app_bar_details.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/pokedex/blocks/catch_details.dart';
import '../models/item.dart';
import '../models/tab.dart';
import '../components/catch_card.dart';
import '../components/type_background.dart';
import '../components/details_header.dart';
import '../components/image.dart';
import '../components/details_panel.dart';

class TrackerDetailsPage extends StatefulWidget {
  const TrackerDetailsPage({
    super.key,
    required this.pokemons,
    required this.indexes,
    required this.onStateChange,
  });

  final List<Item> pokemons;
  final List<int> indexes;
  final Function()? onStateChange;

  @override
  State<TrackerDetailsPage> createState() => _TrackerDetailsPageState();
}

class _TrackerDetailsPageState extends State<TrackerDetailsPage> {
  bool isFirstInList = false;
  bool isLastInList = false;
  bool isEditable = false;
  List<int> currentIndexes = List<int>.empty(growable: true);

  @override
  void initState() {
    currentIndexes.addAll(widget.indexes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFirstInList = widget.pokemons.isFirst(currentIndexes);
    isLastInList = widget.pokemons.isLast(currentIndexes);

    Item displayPokemon = widget.pokemons.current(currentIndexes);
    bool isMobile = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      body: Stack(
        children: [
          TypeBackground(
              type1: displayPokemon.type1, type2: displayPokemon.type2),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    //Main Block
                    Expanded(
                      child: Column(
                        children: [
                          DetailsAppBar(
                            name: displayPokemon.name,
                            number: displayPokemon.number,
                          ),

                          //Image
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.network(
                                '${kImageLocalPrefix}mons/${displayPokemon.displayImage}',
                              ),
                            ),
                          ),

                          //Edit/Save Button
                          ActionButton(
                            // onPress: (isLastInList)
                            //     ? null
                            //     : () => {
                            onPress: () => {
                              setState(() => {
                                    if (isEditable)
                                      {
                                        isEditable = false,
                                        widget.onStateChange!(),
                                      }
                                    else
                                      {
                                        isEditable = true,
                                      }
                                  }),
                            },
                            icon: (isEditable)
                                ? const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                          ),
                        ],
                      ),
                    ),

                    if (!isMobile)
                      //Catch Card Info
                      Expanded(
                        child: Column(
                          children: [
                            CatchDetailsBlock(
                              isEditMode: isEditable,
                              pokemon: displayPokemon,
                              editLocks: createLocks(displayPokemon),
                            ),
                          ],
                        ),
                      )
                    else
                      Expanded(child: Panelv2(tabs: buildTab(displayPokemon))),
                  ],
                ),
              ),

              //SECOND COLUMN
              if (!isMobile)
                const Expanded(
                  child: Column(
                    children: [
                      //Attributes
                      DetailsCard(
                          cardChild: Expanded(
                            child: Center(
                              child: Icon(
                                Icons.not_interested_outlined,
                                size: 150,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          blockTitle: "Attribrutes"),
                      //Ribbons
                      DetailsCard(
                          cardChild: Expanded(
                            child: Center(
                              child: Icon(
                                Icons.not_interested_outlined,
                                size: 150,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          blockTitle: "Ribbons"),
                    ],
                  ),
                ),

              //THIRD COLUMN
              if (!isMobile)
                const Expanded(
                  child: Column(
                    children: [
                      //Marks
                      DetailsCard(
                          cardChild: Expanded(
                            child: Center(
                              child: Icon(
                                Icons.not_interested_outlined,
                                size: 150,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          blockTitle: "Marks"),
                      //Others
                      DetailsCard(
                          cardChild: Expanded(
                            child: Center(
                              child: Icon(
                                Icons.not_interested_outlined,
                                size: 150,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          blockTitle: "TBC"),
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );

    // return Scaffold(
    //   floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    //   floatingActionButton: FloatingActionButton.small(
    //     backgroundColor: const Color(0xFF1D1E33),
    //     // foregroundColor: Colors.white,
    //     onPressed: () {
    //       setState(() => {
    //             if (isEditable)
    //               {
    //                 isEditable = false,
    //                 widget.onStateChange!(),
    //               }
    //             else
    //               {
    //                 isEditable = true,
    //               }
    //           });

    //       // ScaffoldMessenger.of(context).showSnackBar(
    //       //   const SnackBar(
    //       //     content: Text('Under Construction'),
    //       //   ),
    //       // );
    //     },
    //     child: (isEditable) ? const Icon(Icons.save) : const Icon(Icons.edit),
    //   ),
    //   body: Stack(
    //     children: [
    //       TypeBackground(
    //           type1: displayPokemon.type1, type2: displayPokemon.type2),
    //       DetailsAppBar(
    //         name: displayPokemon.name,
    //         number: displayPokemon.number,
    //       ),
    //       DetailsHeader(
    //         type1: displayPokemon.type1,
    //         type2: displayPokemon.type2,
    //       ),
    //       Panel(tabs: giveMeATab(displayPokemon)),
    //       PopScope(
    //           canPop: true,
    //           onPopInvoked: (didPop) {
    //             if (!didPop) {
    //               Navigator.pop(context, false);
    //             }
    //           },
    //           // WillPopScope(
    //           //     onWillPop: () async {
    //           //       Navigator.pop(context, false);
    //           //       return false;
    //           //     },
    //           child: MainImage(imagePath: displayPokemon.displayImage)),
    //     ],
    //   ),
    // );
  }

  buildTab(Item displayPokemon) {
    List<PokeTabv2> tabs = [];
    tabs.addAll([
      PokeTabv2(
        tabName: "Catch Data",
        tabContent: Column(
          children: [
            CatchDetailsBlock(
              isEditMode: isEditable,
              pokemon: displayPokemon,
              editLocks: createLocks(displayPokemon),
            ),
          ],
        ),
      ),
    ]);

    return tabs;
  }

  createLocks(Item pokemon) {
    List<DetailsLock> locks = [];
    // locks.add(DetailsLock.gameOrigin);
    // locks.add(DetailsLock.gameCurrently);
    if (pokemon.gender == PokemonGender.genderless ||
        pokemon.gender == PokemonGender.femaleOnly ||
        pokemon.gender == PokemonGender.maleOnly) {
      locks.add(DetailsLock.gender);
    }

    locks.add(DetailsLock.attributes);

    // if (pokemon.attributes.contains(PokemonAttributes.isShiny)) {
    //   locks.add(DetailsLock.attributesShiny);
    // }

    return locks;
  }
}
