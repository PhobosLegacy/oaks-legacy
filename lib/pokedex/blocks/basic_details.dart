import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/models/pokemon.dart';

class BaseDetailsBlock extends StatelessWidget {
  const BaseDetailsBlock({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Card(
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "The ${pokemon.species}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "#${pokemon.number}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Pokemon.typeImage(pokemon.type1, size: 70),
                            Text(
                              pokemon.type1.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      if (pokemon.type2 != null)
                        const Text(
                          "·",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      if (pokemon.type2 != null)
                        FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Pokemon.typeImage(pokemon.type2, size: 70),
                              Text(
                                pokemon.type2!.name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    pokemon.weight,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                Expanded(
                  child: Text(
                    pokemon.height,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return (MediaQuery.of(context).size.width < 1024)
        ? mainContent
        : DetailsCard(
            cardChild: Expanded(child: mainContent),
            blockTitle: "Base Details");
  }
}
