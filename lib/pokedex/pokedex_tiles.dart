import 'package:flutter/material.dart';
import 'package:oaks_legacy/pokedex/pokedex_details_screen.dart';
import '../components/image.dart';
import '../models/pokemon.dart';

class PokemonTiles extends StatefulWidget {
  const PokemonTiles(
      {super.key,
      required this.pokemons,
      required this.indexes,
      required this.isLowerTile,
      this.onStateChange});

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

    return Card(
      child: ListTile(
        tileColor: (widget.isLowerTile) ? null : Colors.black26,
        textColor: Colors.black,
        onTap: (widget.onStateChange == null)
            ? () => {
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
                }
            : () {
                widget.onStateChange!(widget.indexes);
              },
        leading: Hero(
          tag: pokemon.ref,
          child: ListImage(image: 'mons/${pokemon.image[0]}'),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                //pokemon.name + " (" + pokemon.formName + ")",
                (pokemon.formName == "") ? pokemon.name : pokemon.formName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            SizedBox(
              height: 20,
              child: Pokemon.typeImage(pokemon.type1),
            ),
            if (pokemon.type2 != null) const Text("·"),
            if (pokemon.type2 != null)
              SizedBox(
                height: 20,
                child: Pokemon.typeImage(pokemon.type2),
              ),
          ],
        ),
        trailing: (!widget.isLowerTile)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "#${pokemon.number}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 36),
                ],
              )
            : null,
      ),
    );
  }
}
