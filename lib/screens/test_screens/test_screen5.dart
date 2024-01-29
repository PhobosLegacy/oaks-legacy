import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/app_bar.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/models/pokemon.dart';
import 'package:oaks_legacy/pokedex/pokedex_details_screen.dart';

//GRID VIEW WITH EXPANDED AND OVERFLOW
class TestListScreen5 extends StatefulWidget {
  const TestListScreen5({
    super.key,
  });

  @override
  State<TestListScreen5> createState() => _TestListScreen5State();
}

class _TestListScreen5State extends State<TestListScreen5> {
  @override
  build(BuildContext context) {
    kPokedex = kPokedex
        .where((element) =>
            element.name == "Bulbasaur" ||
            element.name == "Venusaur" ||
            element.name == "Alcremie" ||
            element.name == "Tauros" ||
            element.name == "Urshifu" ||
            element.name == "Unown")
        .toList();
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
      body: Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 6, // Adjust the cross axis count as needed
            childAspectRatio: 2,
          ),
          itemCount: kPokedex.length,
          itemBuilder: (context, index) {
            return PokemonTiles(
              isLowerTile: false,
              pokemons: kPokedex,
              indexes: [index],
              onStateChange: null,
            );
          },
        ),
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
      onTap: (widget.onStateChange == null)
          ? () => {
                if (pokemon.forms.isEmpty)
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
                  showDialog(
                    barrierColor: Colors.black54,
                    context: context,
                    builder: (BuildContext context) {
                      return ShowForms(
                        isLowerTile: false,
                        forms: pokemon.forms,
                        indexes: [...widget.indexes],
                        onStateChange: null,
                      );
                    },
                  )
              }
          : () {
              widget.onStateChange!(widget.indexes);
            },
      child: Card(
        color: (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Hero(
                      tag: pokemon.ref,
                      child: ListImage(image: 'mons/${pokemon.image[0]}'),
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

    return SizedBox(height: 220, width: 420, child: stack);
  }

  // List<Widget> createChildren() {
  //   Pokemon pokemon = kPokedex.current(widget.indexes);
  //   List<PokemonTiles> tiles = [];

  //   for (var i = 0; i < pokemon.forms.length; i++) {
  //     tiles.add(PokemonTiles(
  //         pokemons: kPokedex,
  //         indexes: [...widget.indexes, i],
  //         isLowerTile: true));
  //   }
  //   return tiles;
  // }
}

// class ShowForms extends StatelessWidget {
//   const ShowForms({
//     super.key,
//     required this.forms,
//     required this.indexes,
//     required this.isLowerTile,
//     this.onStateChange,
//   });

//   final bool isLowerTile;
//   final List<Pokemon> forms;
//   final List<int> indexes;
//   final Function(List<int>)? onStateChange;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             'Choose a Variation',
//             style: TextStyle(
//               color: Colors.amber,
//               fontSize: 24,
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           GridView.count(
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 5,
//             crossAxisCount: 6,
//             childAspectRatio: 2,
//             shrinkWrap: true,
//             // physics: NeverScrollableScrollPhysics(),
//             // To prevent scrolling within the GridView
//             padding: const EdgeInsets.all(5),
//             children: List.generate(forms.length, (index) {
//               return PokemonTiles(
//                 isLowerTile: true,
//                 pokemons: forms,
//                 indexes: [...indexes, index],
//                 onStateChange: null,
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
          Wrap(
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
        ],
      ),
    );
  }
}
