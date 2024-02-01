import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/app_bar.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/pokemon.dart';
import 'package:oaks_legacy/pokedex/pokedex_details_screen.dart';

//TEST 6 BUT USING WRAP/Lazy Load and Formatting FROM 1
class TestListScreen6 extends StatefulWidget {
  const TestListScreen6({
    super.key,
  });

  @override
  State<TestListScreen6> createState() => _TestListScreen6State();
}

initialLoad() => 20;
scrollLoad() => 10;
// initialLoad() => kPokedex.length;
// scrollLoad() => 0;
// updateTempDex() => kPokedex = kPokedex
//     .where((element) =>
//         element.name == "Bulbasaur" ||
//         element.name == "Venusaur" ||
//         element.name == "Alcremie" ||
//         element.name == "Tauros" ||
//         element.name == "Urshifu" ||
//         element.name == "Arceus" ||
//         element.name == "Articuno" ||
//         element.name == "Charizard" ||
//         element.name == "Indeedee" ||
//         element.name == "Koraidon" ||
//         element.name == "Miraidon" ||
//         element.name == "Ogerpon" ||
//         element.name == "Unown")
//     .toList();

class _TestListScreen6State extends State<TestListScreen6> {
  // var a = updateTempDex();
  ScrollController scrollController = ScrollController();
  List<int> data = List.generate(initialLoad(), (index) => index);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreItems);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _loadMoreItems() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Load more items when scrolled to the end
      setState(() {
        data.addAll(
            List.generate(scrollLoad(), (index) => data.length + index));
      });
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        title: const Text(
          "Pokedex",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey[800],
        actions: null,
      ),
      body: Stack(
        children: [
          const BaseBackground(),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        alignment: WrapAlignment.center,
                        children: data.map((index) {
                          return PokemonTiles(
                            isLowerTile: false,
                            pokemons: kPokedex.take(data.length).toList(),
                            indexes: [index],
                            onStateChange: null,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonTiles extends StatefulWidget {
  const PokemonTiles({
    super.key,
    required this.pokemons,
    required this.indexes,
    required this.isLowerTile,
    this.onStateChange,
  });

  final bool isLowerTile;
  final List<Pokemon> pokemons;
  final List<int> indexes;
  final Function(List<int>)? onStateChange;

  @override
  State<PokemonTiles> createState() => _PokemonTiles();
}

class _PokemonTiles extends State<PokemonTiles> {
  @override
  Widget build(BuildContext context) {
    Pokemon pokemon = kPokedex.current(widget.indexes);

    double currentWidth = MediaQuery.of(context).size.width;
    int cardsPerRow = currentWidth ~/ 400;
    double width = currentWidth / cardsPerRow - 12.0;
    double height = (cardsPerRow > 1) ? 220 : 110;

    var stack = GestureDetector(
      onTap: (pokemon.forms.isEmpty)
          ? () => {
                if (widget.onStateChange == null)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PokedexDetailsPage(
                          pokemons: kPokedex,
                          indexes: widget.indexes,
                        );
                      },
                    ),
                  )
                else
                  widget.onStateChange!(widget.indexes),
              }
          : () {
              showDialog(
                barrierColor: Colors.black87,
                context: context,
                builder: (BuildContext context) {
                  return ShowForms(
                    isLowerTile: true,
                    forms: pokemon.forms,
                    indexes: [...widget.indexes],
                    onStateChange: null,
                  );
                },
              );
            },
      child: Card(
        color: (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: (cardsPerRow > 1) ? dRow(pokemon) : mRow(pokemon),
            ),
            //FORMS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (pokemon.forms.isNotEmpty)
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    // Icons.keyboard_double_arrow_down,
                    color: Colors.white,
                  ),
                Text(
                  (pokemon.forms.isNotEmpty)
                      ? '+${pokemon.forms.length - 1}'
                      : "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return SizedBox(
        width: (widget.isLowerTile) ? width * 0.9 : width,
        height: (widget.isLowerTile) ? height * 0.9 : height,
        child: stack);
  }

  getName(Pokemon pokemon) {
    if (!widget.isLowerTile) return pokemon.name;
    if (pokemon.forms.isNotEmpty) return pokemon.name;
    if (pokemon.formName == "") return pokemon.name;
    return pokemon.formName;
  }

  mRow(Pokemon pokemon) {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: pokemon.ref,
            child: ListImage(
              image: 'mons/${pokemon.image[0]}',
              // height: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Expanded(
          flex: (widget.isLowerTile) ? 3 : 2,
          child: Column(
            crossAxisAlignment: (widget.isLowerTile)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisAlignment: (widget.isLowerTile)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  getName(pokemon),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20 * MediaQuery.of(context).textScaleFactor),
                ),
              ),
              Row(
                mainAxisAlignment: (widget.isLowerTile)
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Pokemon.typeImage(pokemon.type1),
                  if (pokemon.type2 != null)
                    const Text(
                      "·",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  if (pokemon.type2 != null) Pokemon.typeImage(pokemon.type2),
                ],
              ),
            ],
          ),
        ),
        if (!widget.isLowerTile)
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "#${pokemon.number}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20 * MediaQuery.of(context).textScaleFactor),
              ),
            ),
          ),
      ],
    );
  }

  dRow(Pokemon pokemon) {
    return Row(
      children: [
        Hero(
          tag: pokemon.ref,
          child: ListImage(
            image: 'mons/${pokemon.image[0]}',
            // height: MediaQuery.of(context).size.width,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: (widget.isLowerTile)
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              //NAME
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        getName(pokemon),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),

              //NUMBER
              if (!widget.isLowerTile)
                Expanded(
                  child: Text(
                    "#${pokemon.number}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                ),

              //TYPE
              Expanded(
                child: Row(
                  mainAxisAlignment: (widget.isLowerTile)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Pokemon.typeImage(pokemon.type1, height: 50)),
                    ),
                    if (pokemon.type2 != null)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "·",
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        ),
                      ),
                    if (pokemon.type2 != null)
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Pokemon.typeImage(pokemon.type2, height: 50),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShowForms extends StatelessWidget {
  const ShowForms({
    super.key,
    required this.forms,
    required this.indexes,
    required this.isLowerTile,
    this.onStateChange,
  });

  final bool isLowerTile;
  final List<Pokemon> forms;
  final List<int> indexes;
  final Function(List<int>)? onStateChange;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          iconSize: 50,
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ),
      Expanded(
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.center,
              children: forms.map((pokemon) {
                final index = forms.indexOf(pokemon);
                return PokemonTiles(
                  isLowerTile: true,
                  pokemons: forms,
                  indexes: [...indexes, index],
                  onStateChange: null,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ]);
  }
}
