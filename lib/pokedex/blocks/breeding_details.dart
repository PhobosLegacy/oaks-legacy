import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/models/pokemon.dart';

class BreedingBlock extends StatelessWidget {
  const BreedingBlock({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Column(
      children: [
        Expanded(
            child: Card(
          color: Colors.black12,
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${pokemon.genderRatio.male}%',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const Icon(
                        Icons.male,
                        color: Colors.blueAccent,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${pokemon.genderRatio.female}%',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const Icon(
                        Icons.female,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //                 textTitle: 'cycles ${pokemon.breeding.getSteps()}',
                      //                 textValue: pokemon.breeding.cycles,
                      Text(
                        pokemon.breeding.cycles,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        'cycles ${pokemon.breeding.getSteps()}',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: AutoSizeText(
                          pokemon.breeding.groups.toString(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                      ),
                      const Text(
                        'Egg Groups',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return (MediaQuery.of(context).size.width < 1024)
        ? mainContent
        : DetailsCard(
            cardChild: Expanded(child: mainContent), blockTitle: "Breeding");
  }
}
