import 'package:flutter/material.dart';
import 'package:proto_dex/components/app_bar_details.dart';
import 'package:proto_dex/models/enums.dart';
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

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color(0xFF1D1E33),
        // foregroundColor: Colors.white,
        onPressed: () {
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
              });

          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Under Construction'),
          //   ),
          // );
        },
        child: (isEditable) ? const Icon(Icons.save) : const Icon(Icons.edit),
      ),
      body: Stack(
        children: [
          TypeBackground(
              type1: displayPokemon.type1, type2: displayPokemon.type2),
          DetailsAppBar(
            name: displayPokemon.name,
            number: displayPokemon.number,
          ),
          DetailsHeader(
            type1: displayPokemon.type1,
            type2: displayPokemon.type2,
          ),
          Panel(tabs: giveMeATab(displayPokemon)),
          WillPopScope(
              onWillPop: () async {
                Navigator.pop(context, false);
                return false;
              },
              child: MainImage(imagePath: displayPokemon.displayImage)),
        ],
      ),
    );
  }

  giveMeATab(originalPokemon) {
    List<PokeTab> tabs = [];

    tabs.add(
      PokeTab(
        tabName: "Details",
        leftCard: CatchInformationCard(
          pokemon: originalPokemon,
          isEditable: isEditable,
          locks: createLocks(originalPokemon),
        ),
        rightCard: Container(),
      ),
    );

    return tabs;
  }

  createLocks(Item pokemon) {
    List<DetailsLock> locks = [];
    locks.add(DetailsLock.gameOrigin);
    locks.add(DetailsLock.gameCurrently);
    if (pokemon.gender != PokemonGender.undefinied) {
      locks.add(DetailsLock.gender);
    }

    locks.add(DetailsLock.attributes);

    // if (pokemon.attributes.contains(PokemonAttributes.isShiny)) {
    //   locks.add(DetailsLock.attributesShiny);
    // }

    return locks;
  }
}
