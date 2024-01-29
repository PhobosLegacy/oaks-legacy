import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/pokemon.dart';

//GRID VIEW WITH EXPANDED AND OVERFLOW
class TestListScreen4 extends StatefulWidget {
  const TestListScreen4({
    super.key,
  });

  @override
  State<TestListScreen4> createState() => _TestListScreen4State();
}

class _TestListScreen4State extends State<TestListScreen4> {
  @override
  build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        // Adjust the cross axis count as needed
        crossAxisCount: 6,
        // Increase to get a bigger width, reduce to get bigger height
        childAspectRatio: 2,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,

        children: List.generate(kPokedex.length, (index) {
          return PokemonTiles(
            isLowerTile: false,
            pokemons: kPokedex,
            indexes: [index],
            onStateChange: null,
          );
        }),
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
    Pokemon pokemon = widget.pokemons.current(widget.indexes);

    return OverflowBox(
      maxHeight: 1000,
      alignment: Alignment.topCenter,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          trailing: const SizedBox(),
          // subtitle: Text(
          //   "Icaro",
          //   style: TextStyle(fontSize: 20),
          // ),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Hero(
                  tag: pokemon.ref,
                  child: SizedBox(
                      child: ListImage(image: 'mons/${pokemon.image[0]}')),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Center(
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
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Pokemon.typeImage(pokemon.type1),
                        ),
                        if (pokemon.type2 != null)
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "·",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50),
                            ),
                          ),
                        if (pokemon.type2 != null)
                          SizedBox(
                            height: 50,
                            child: Pokemon.typeImage(pokemon.type2),
                          ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          backgroundColor: Colors.lightGreen,
          collapsedBackgroundColor:
              (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,

          children: [
            if (pokemon.forms.isNotEmpty) ...createChildren(),
          ],
        ),
      ),
    );
  }

  List<Widget> createChildren() {
    Pokemon pokemon = widget.pokemons.current(widget.indexes);
    List<PokemonTiles> tiles = [];

    for (var i = 0; i < pokemon.forms.length; i++) {
      tiles.add(PokemonTiles(
          pokemons: widget.pokemons,
          indexes: [...widget.indexes, i],
          isLowerTile: true));
    }
    return tiles;
  }
}
