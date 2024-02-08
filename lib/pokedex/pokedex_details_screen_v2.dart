import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/action_button.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import '../components/details_next_prev.dart';
import '../components/app_bar_details.dart';
import '../models/tab.dart';
import '../components/breeding_card.dart';
import '../components/type_background.dart';
import '../components/details_header.dart';
import '../components/image.dart';
import '../components/games_card.dart';
import '../components/general_card.dart';
import '../components/details_panel.dart';
import '../models/pokemon.dart';
import '../components/weakness_card.dart';

class PokedexDetailsPageV2 extends StatefulWidget {
  const PokedexDetailsPageV2(
      {super.key, required this.pokemons, required this.indexes});

  final List<Pokemon> pokemons;
  final List<int> indexes;

  @override
  State<PokedexDetailsPageV2> createState() => _PokedexDetailsPageV2();
}

class _PokedexDetailsPageV2 extends State<PokedexDetailsPageV2> {
  int imageIndex = 0;
  bool isFirstInList = false;
  bool isLastInList = false;
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

    Pokemon pokemon = widget.pokemons.current(currentIndexes);

    if (MediaQuery.of(context).size.width < 1024) {
      return Scaffold(
        body: Stack(
          children: [
            TypeBackground(type1: pokemon.type1, type2: pokemon.type2),
            DetailsAppBar(
              name: pokemon.name,
              number: pokemon.number,
            ),
            DetailsHeader(
              type1: pokemon.type1,
              type2: pokemon.type2,
            ),
            Panel(tabs: buildTab(pokemon)),
            PopScope(
                canPop: true,
                onPopInvoked: (didPop) {
                  if (!didPop) {
                    imageIndex = 0;
                    Navigator.pop(context, false);
                  }
                },
                // WillPopScope(
                //     onWillPop: () async {
                //       imageIndex = 0;
                //       Navigator.pop(context, false);
                //       return false;
                //     },
                child: Hero(
                    tag: pokemon.ref,
                    child: MainImage(imagePath: pokemon.image[imageIndex]))),
            NextPrevButtons(
              onLeftClick: (isFirstInList)
                  ? null
                  : () => {
                        setState(() {
                          imageIndex = 0;
                          pokemon.resetImage();
                          currentIndexes =
                              widget.pokemons.previousIndex(currentIndexes);
                        }),
                      },
              onRightClick: (isLastInList)
                  ? null
                  : () => {
                        setState(() {
                          imageIndex = 0;
                          pokemon.resetImage();
                          currentIndexes =
                              widget.pokemons.nextIndex(currentIndexes);
                        }),
                      },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          TypeBackground(type1: pokemon.type1, type2: pokemon.type2),
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DetailsAppBar(
                            name: pokemon.name,
                            number: pokemon.number,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.network(
                                '${kImageLocalPrefix}mons/${pokemon.image[imageIndex]}',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Go LEFT
                              ActionButton(
                                onPress: (isFirstInList)
                                    ? null
                                    : () => {
                                          setState(() {
                                            imageIndex = 0;
                                            pokemon.resetImage();
                                            currentIndexes = widget.pokemons
                                                .previousIndex(currentIndexes);
                                          }),
                                        },
                                icon: const Icon(
                                  Icons.arrow_circle_left_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  if (pokemon.imageHasGenderAlter())
                                    //FEMALE VERSION
                                    ActionButton(
                                      onPress: () => {
                                        setState(() {
                                          imageIndex =
                                              pokemon.findImageIndexByGender(
                                                  PokemonGender.female);
                                        }),
                                      },
                                      icon: (pokemon.imageGender() ==
                                              PokemonGender.female)
                                          ? const Icon(Icons.female,
                                              color: Colors.red)
                                          : const Icon(Icons.female,
                                              color: Colors.grey),
                                    ),

                                  //SHINY VARIANT
                                  ActionButton(
                                    onPress: () => {
                                      setState(() {
                                        (pokemon.imageVariant() ==
                                                PokemonVariant.normal)
                                            ? imageIndex =
                                                pokemon.findImageIndexByVariant(
                                                    PokemonVariant.shiny)
                                            : imageIndex =
                                                pokemon.findImageIndexByVariant(
                                                    PokemonVariant.normal);
                                      }),
                                    },
                                    icon: (pokemon.imageVariant() ==
                                            PokemonVariant.normal)
                                        ? Image.network(
                                            '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
                                            color: Colors.grey,
                                            height: 20,
                                            width: 24,
                                          )
                                        : Image.network(
                                            '$kImageLocalPrefix/icons/box_icon_shiny_01.png',
                                            color: Colors.amber,
                                            height: 20,
                                            width: 24,
                                          ),
                                  ),

                                  if (pokemon.imageHasGenderAlter())
                                    //MALE VERSION
                                    ActionButton(
                                      onPress: () => {
                                        setState(() {
                                          imageIndex =
                                              pokemon.findImageIndexByGender(
                                                  PokemonGender.male);
                                        }),
                                      },
                                      icon: (pokemon.imageGender() ==
                                              PokemonGender.male)
                                          ? const Icon(Icons.male,
                                              color: Colors.blue)
                                          : const Icon(Icons.male,
                                              color: Colors.grey),
                                    ),
                                ],
                              ),

                              //GO RIGHT
                              ActionButton(
                                onPress: (isLastInList)
                                    ? null
                                    : () => {
                                          setState(() {
                                            imageIndex = 0;
                                            pokemon.resetImage();
                                            currentIndexes = widget.pokemons
                                                .nextIndex(currentIndexes);
                                          }),
                                        },
                                icon: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // NextPrevButtons(
                          //   onLeftClick: (isFirstInList)
                          //       ? null
                          //       : () => {
                          //             setState(() {
                          //               imageIndex = 0;
                          //               pokemon.resetImage();
                          //               currentIndexes = widget.pokemons
                          //                   .previousIndex(currentIndexes);
                          //             }),
                          //           },
                          //   onRightClick: (isLastInList)
                          //       ? null
                          //       : () => {
                          //             setState(() {
                          //               imageIndex = 0;
                          //               pokemon.resetImage();
                          //               currentIndexes = widget.pokemons
                          //                   .nextIndex(currentIndexes);
                          //             }),
                          //           },
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          GeneralInformationCard(
                            pokemon: pokemon,
                            onImageChange: (int newIndex) {
                              setState(() => imageIndex = newIndex);
                            },
                          ),
                        ],
                      ),
                    ),
                    BreedingInformationCard(
                      pokemon: pokemon,
                      onImageChange: (int newIndex) {
                        setState(() => imageIndex = newIndex);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    GamesInformationCard(pokemon: pokemon),
                    WeaknessInformationCard(pokemon: pokemon),
                    tempContainer(Colors.cyan),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildTab(Pokemon pokemon) {
    List<PokeTab> tabs = [];
    tabs.add(
      PokeTab(
        tabName: "About",
        leftCard: GeneralInformationCard(
          pokemon: pokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
        rightCard: BreedingInformationCard(
          pokemon: pokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
      ),
    );

    tabs.add(PokeTab(
      tabName: "More",
      leftCard: GamesInformationCard(pokemon: pokemon),
      rightCard: WeaknessInformationCard(pokemon: pokemon),
    ));

    return tabs;
  }

  tempContainer(Color color) {
    return Expanded(
      flex: 2,
      child: Container(
        color: color,
      ),
    );
  }
}
