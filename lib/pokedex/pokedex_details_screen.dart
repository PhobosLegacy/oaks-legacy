import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/action_button.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/pokedex/blocks/basic_details.dart';
import 'package:oaks_legacy/pokedex/blocks/breeding_details.dart';
import 'package:oaks_legacy/pokedex/blocks/games_details.dart';
import 'package:oaks_legacy/pokedex/blocks/weakness_details.dart';
import '../components/app_bar_details.dart';
import '../models/tab.dart';
import '../components/type_background.dart';
import '../components/details_panel.dart';
import '../models/pokemon.dart';

class PokedexDetailsPage extends StatefulWidget {
  const PokedexDetailsPage(
      {super.key, required this.pokemons, required this.indexes});

  final List<Pokemon> pokemons;
  final List<int> indexes;

  @override
  State<PokedexDetailsPage> createState() => _PokedexDetailsPage();
}

class _PokedexDetailsPage extends State<PokedexDetailsPage> {
  int imageIndex = 0;
  bool isFirstInList = false;
  bool isLastInList = false;
  List<int> currentIndexes = List<int>.empty(growable: true);

  @override
  void initState() {
    currentIndexes.addAll(widget.indexes);
    super.initState();
  }

  void prefetchImages() {
    isFirstInList = widget.pokemons.isFirst(currentIndexes);
    if (!isFirstInList) {
      Pokemon pokemon = widget.pokemons
          .current(widget.pokemons.previousIndex(currentIndexes));
      cache(pokemon.image);
      pokemon =
          widget.pokemons.current(widget.pokemons.nextIndex(currentIndexes));
    }

    isLastInList = widget.pokemons.isLast(currentIndexes);
    if (!isLastInList) {
      Pokemon pokemon =
          widget.pokemons.current(widget.pokemons.nextIndex(currentIndexes));
      cache(pokemon.image);
      pokemon = widget.pokemons
          .current(widget.pokemons.previousIndex(currentIndexes));
    }

    Pokemon pokemon = widget.pokemons.current(currentIndexes);
    cache(pokemon.image);
  }

  void cache(images) {
    for (final imagePath in images) {
      precacheImage(
          NetworkImage('${kImageLocalPrefix}mons/$imagePath'), context);
    }
  }

  @override
  void didChangeDependencies() {
    prefetchImages();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isFirstInList = widget.pokemons.isFirst(currentIndexes);
    isLastInList = widget.pokemons.isLast(currentIndexes);

    Pokemon pokemon = widget.pokemons.current(currentIndexes);
    bool isMobile = MediaQuery.of(context).size.width < 1024;
    if (isMobile) {
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
                            createButtons(pokemon),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // BaseDetailsBlock(pokemon: pokemon),
                Expanded(child: Panelv2(tabs: buildTab(pokemon))),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          TypeBackground(type1: pokemon.type1, type2: pokemon.type2),
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
                          createButtons(pokemon),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          BaseDetailsBlock(pokemon: pokemon),
                          BreedingBlock(pokemon: pokemon)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    GamesBlock(pokemon: pokemon),
                    WeaknessBlock(pokemon: pokemon),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  children: [
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
                        blockTitle: "Stats"),
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
                        blockTitle: "Stats"),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget createButtons(Pokemon pokemon) {
    return Row(
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
                      currentIndexes =
                          widget.pokemons.previousIndex(currentIndexes);
                      prefetchImages();
                    }),
                  },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pokemon.imageHasGenderAlter())
              //MALE VERSION
              ActionButton(
                onPress: () => {
                  setState(() {
                    imageIndex =
                        pokemon.findImageIndexByGender(PokemonGender.male);
                  }),
                },
                icon: (pokemon.imageGender() == PokemonGender.male)
                    ? const Icon(Icons.male, color: Colors.blue)
                    : const Icon(Icons.male, color: Colors.grey),
              ),

            //SHINY VARIANT
            ActionButton(
              onPress: () => {
                setState(() {
                  (pokemon.imageVariant() == PokemonVariant.normal)
                      ? imageIndex =
                          pokemon.findImageIndexByVariant(PokemonVariant.shiny)
                      : imageIndex = pokemon
                          .findImageIndexByVariant(PokemonVariant.normal);
                }),
              },
              icon: (pokemon.imageVariant() == PokemonVariant.normal)
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
              //FEMALE VERSION
              ActionButton(
                onPress: () => {
                  setState(() {
                    imageIndex =
                        pokemon.findImageIndexByGender(PokemonGender.female);
                  }),
                },
                icon: (pokemon.imageGender() == PokemonGender.female)
                    ? const Icon(Icons.female, color: Colors.red)
                    : const Icon(Icons.female, color: Colors.grey),
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
                      currentIndexes =
                          widget.pokemons.nextIndex(currentIndexes);
                      prefetchImages();
                    }),
                  },
          icon: const Icon(
            Icons.arrow_circle_right_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  buildTab(Pokemon pokemon) {
    List<PokeTabv2> tabs = [];
    tabs.addAll([
      PokeTabv2(
        tabName: "Base",
        tabContent: Column(
          children: [
            Expanded(flex: 2, child: BaseDetailsBlock(pokemon: pokemon)),
            Expanded(child: BreedingBlock(pokemon: pokemon)),
          ],
        ),
      ),
      PokeTabv2(
        tabName: "Games",
        tabContent: GamesBlock(pokemon: pokemon),
      ),
      PokeTabv2(
        tabName: "Weak",
        tabContent: WeaknessBlock(pokemon: pokemon),
      ),
    ]);

    return tabs;
  }
}
