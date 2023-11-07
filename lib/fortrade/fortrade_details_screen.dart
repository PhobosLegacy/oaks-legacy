import 'package:flutter/material.dart';
import '../models/enums.dart';
import '../models/item.dart';
import '../models/tab.dart';
import '../components/details_header.dart';
import '../components/catch_card.dart';
import '../components/type_background.dart';
import '../components/image.dart';
import '../components/details_panel.dart';

class ForTradeDetailsPage extends StatefulWidget {
  const ForTradeDetailsPage({
    super.key,
    required this.pokemons,
    required this.indexes,
    required this.onStateChange,
  });

  final List<Item> pokemons;
  final List<int> indexes;
  final Function(Item)? onStateChange;

  @override
  State<ForTradeDetailsPage> createState() => _ForTradeDetailsPageState();
}

class _ForTradeDetailsPageState extends State<ForTradeDetailsPage> {
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
                    displayPokemon.displayImage =
                        displayPokemon.updateDisplayImage(),
                    widget.onStateChange!(displayPokemon),
                  }
                else
                  {
                    isEditable = true,
                  }
              });
        },
        child: (isEditable) ? const Icon(Icons.save) : const Icon(Icons.edit),
      ),
      body: Stack(
        children: [
          TypeBackground(
              type1: displayPokemon.type1, type2: displayPokemon.type2),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          DetailsHeader(
            name: displayPokemon.name,
            number: displayPokemon.number,
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
    if (originalPokemon is Item) {
      tabs.insert(
        0,
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
    }
    return tabs;
  }

  createLocks(Item pokemon) {
    List<DetailsLock> locks = [];
    if (pokemon.origin.startsWith('t_')) {}
    if (pokemon.gender == PokemonGender.genderless) {
      locks.add(DetailsLock.gender);
    }
    return locks;
  }
}
