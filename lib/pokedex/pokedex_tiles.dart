import 'package:flutter/material.dart';
import 'package:oaks_legacy/pokedex/pokedex_details_screen.dart';
import '../components/image.dart';
import '../models/pokemon.dart';
import 'pokedex_forms.dart';

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
                          pokemons: widget.pokemons,
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
                    pokemons: widget.pokemons,
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
