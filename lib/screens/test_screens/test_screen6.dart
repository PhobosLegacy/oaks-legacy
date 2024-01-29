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

initialLoad() => kPokedex.length;
scrollLoad() => 10;
updateTempDex() => kPokedex = kPokedex
    .where((element) =>
        element.name == "Bulbasaur" ||
        element.name == "Venusaur" ||
        element.name == "Alcremie" ||
        element.name == "Tauros" ||
        element.name == "Urshifu" ||
        element.name == "Arceus" ||
        element.name == "Charizard" ||
        element.name == "Indeedee" ||
        element.name == "Koraidon" ||
        element.name == "Miraidon" ||
        element.name == "Ogerpon" ||
        element.name == "Unown")
    .toList();

class _TestListScreen6State extends State<TestListScreen6> {
  var a = updateTempDex();
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
                child: Row(
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
                        children: [
                          //NAME
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    (pokemon.formName == "")
                                        ? pokemon.name
                                        : pokemon.formName,
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
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "#${pokemon.number}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 36),
                              ],
                            ),
                          ),
                          //TYPE
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Pokemon.typeImage(pokemon.type1)),
                                ),
                                if (pokemon.type2 != null)
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "·",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 50),
                                      ),
                                    ),
                                  ),
                                if (pokemon.type2 != null)
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Pokemon.typeImage(pokemon.type2),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
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

    //Card size
    //(MediaQuery.of(context).size.width ~/ 400)  Returns a int representing how many cards per row
    return SizedBox(
        width: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.width ~/ 400) -
            12.0,
        height: 100,
        child: stack);
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose a Variation',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16.0),
          SingleChildScrollView(
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
        ],
      ),
    );
  }
}
