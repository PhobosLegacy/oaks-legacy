import 'package:flutter/material.dart';
import '../../components/basic.dart';
import '../../models/pokemon.dart';

class GeneralInformationCard extends StatelessWidget {
  const GeneralInformationCard({
    super.key,
    required this.pokemon,
    required this.onImageChange,
  });

  final Pokemon pokemon;
  final Function(int p1) onImageChange;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "",
      cardChild: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Column(
            children: [
              const SubTextDivider(text: "Base"),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        '#${pokemon.number}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        pokemon.species,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          pokemon.height,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          pokemon.weight,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SubTextDivider(text: "Abilities"),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      children: pokemon.abilities
                          .map(
                            (i) => Text(
                              "$i",
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                          .toList(),
                    ),
                    if (pokemon.hiddenAbility != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (pokemon.hiddenAbility != "")
                            RichText(
                              text: TextSpan(
                                text: "${pokemon.hiddenAbility}",
                                style: const TextStyle(color: Colors.white),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: ' (hidden ability)',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
              // const TextDivider(text: "Variant"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton(
              //       style: ButtonStyle(
              //         backgroundColor:
              //             MaterialStateProperty.all<Color>(Colors.blueGrey),
              //       ),
              //       onPressed: () => {
              //         (pokemon.imageVariant() == PokemonVariant.normal)
              //             ? onImageChange(pokemon
              //                 .findImageIndexByVariant(PokemonVariant.shiny))
              //             : onImageChange(pokemon
              //                 .findImageIndexByVariant(PokemonVariant.normal)),
              //       },
              //       child: (pokemon.imageVariant() == PokemonVariant.normal)
              //           ? const Icon(Icons.star_border)
              //           : const Icon(Icons.circle_outlined),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
