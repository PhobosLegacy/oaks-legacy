import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_tile.dart';
import 'package:oaks_legacy/components/pkm_tile_image.dart';
import 'package:oaks_legacy/pokedex/pokedex_details_screen.dart';
import 'package:oaks_legacy/models/pokemon.dart';
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

    return PkmTile(
      isLowerTile: widget.isLowerTile,
      desktopContent: tileContent(pokemon, false),
      mobileContent: tileContent(pokemon, true),
      onTap: (pokemon.forms.isEmpty)
          ? () => {
                if (widget.onStateChange == null)
                  navigateToPokedexDetails()
                else
                  widget.onStateChange!(widget.indexes),
              }
          : () {
              openFormsDialog();
            },
    );
  }

  getPokemonDisplayName(Pokemon pokemon) {
    if (!widget.isLowerTile) return pokemon.name;
    if (pokemon.forms.isNotEmpty) return pokemon.name;
    if (pokemon.formName == "") return pokemon.name;
    return pokemon.formName;
  }

  tileContent(Pokemon pokemon, bool isMobileView) {
    return Row(
      children: [
        PkmTileImage(
          heroTag: pokemon.ref,
          image: 'mons/${pokemon.image[0]}',
        ),
        Expanded(
          child: Column(
            children: [
              //NAME
              Expanded(
                flex: (widget.isLowerTile) ? 3 : 2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    getPokemonDisplayName(pokemon),
                    textScaler: const TextScaler.linear(1.3),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: (isMobileView) ? 15 : 30),
                  ),
                ),
              ),

              //NUMBER
              //DESKTOP ONLY
              if (!widget.isLowerTile && !isMobileView)
                pokemonNumber(pokemon, isMobileView),

              //TYPE
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Pokemon.typeImage(pokemon.type1, size: 50)),
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
                          child: Pokemon.typeImage(pokemon.type2, size: 50),
                        ),
                      ),
                  ],
                ),
              ),

              //HAS FORMS TO EXPAND
              Expanded(
                child: (pokemon.forms.isNotEmpty)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (pokemon.forms.isNotEmpty)
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              // Icons.keyboard_double_arrow_down,
                              color: Colors.white,
                            ),
                          Text(
                            '+${pokemon.forms.length - 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (isMobileView) ? 10 : 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              )
            ],
          ),
        ),

        //NUMBER
        //(IN MOBILE VIEW DISPLAYED IN THE RIGHT CORNER INSTEAD)
        if (!widget.isLowerTile && isMobileView)
          pokemonNumber(pokemon, isMobileView),
      ],
    );
  }

  pokemonNumber(Pokemon pokemon, bool isMobileView) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "#${pokemon.number}",
          textScaler: const TextScaler.linear(1.3),
          style: TextStyle(
              color: Colors.white, fontSize: (isMobileView) ? 12 : 20),
        ),
      ),
    );
  }

  navigateToPokedexDetails() {
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
    );
  }

  openFormsDialog() {
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (BuildContext context) {
        return ShowForms(
          isLowerTile: true,
          pokemons: widget.pokemons,
          indexes: [...widget.indexes],
          onStateChange: widget.onStateChange,
        );
      },
    );
  }
}
