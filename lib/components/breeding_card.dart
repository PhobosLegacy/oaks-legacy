import 'package:flutter/material.dart';
import '../../components/basic.dart';
import '../../models/enums.dart';
import '../../models/pokemon.dart';

class BreedingInformationCard extends StatelessWidget {
  const BreedingInformationCard({
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
              const SubTextDivider(text: "Breeding"),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceAround,
                      children: pokemon.breeding.groups
                          .map((i) => Text(
                                "[$i]",
                                style: const TextStyle(color: Colors.white),
                              ))
                          .toList(),
                    ),
                    if (pokemon.genderRatio.genderless == "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.male,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                '${pokemon.genderRatio.male}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.female,
                                color: Colors.redAccent,
                              ),
                              Text(
                                '${pokemon.genderRatio.female}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      const Center(
                        child: Text(
                          '(Genderless)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: pokemon.breeding.cycles,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: " cycles${pokemon.breeding.getSteps()}",
                                style: const TextStyle(
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
              const TextDivider(text: "Variants"),
              Expanded(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: const Size.square(10),
                      ),
                      onPressed: () => {
                        (pokemon.imageVariant() == PokemonVariant.normal)
                            ? onImageChange(pokemon
                                .findImageIndexByVariant(PokemonVariant.shiny))
                            : onImageChange(pokemon.findImageIndexByVariant(
                                PokemonVariant.normal)),
                      },
                      child: (pokemon.imageVariant() == PokemonVariant.normal)
                          ? const Icon(Icons.star_border)
                          : const Icon(Icons.circle_outlined),
                    ),
                    if (pokemon.imageHasGenderAlter())
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                minimumSize: const Size.square(10),
                              ),
                              onPressed: () => {
                                onImageChange(
                                  pokemon.findImageIndexByGender(
                                      PokemonGender.male),
                                ),
                              },
                              child: (pokemon.imageGender() ==
                                      PokemonGender.male)
                                  ? const Icon(Icons.male, color: Colors.blue)
                                  : const Icon(Icons.male, color: Colors.grey),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                minimumSize: const Size.square(10),
                              ),
                              onPressed: () => {
                                onImageChange(
                                  pokemon.findImageIndexByGender(
                                      PokemonGender.female),
                                )
                              },
                              child: (pokemon.imageGender() ==
                                      PokemonGender.female)
                                  ? const Icon(Icons.female, color: Colors.red)
                                  : const Icon(Icons.female,
                                      color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                  ],
                  // children: genderButtons(pokemon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
