import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/models/pokemon.dart';

class WeaknessBlock extends StatelessWidget {
  const WeaknessBlock({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    double iconSize = (MediaQuery.of(context).size.width < 1024)
        ? 25
        : MediaQuery.of(context).size.width / 35;
    Widget mainContent = Column(
      children: [
        Weak(
          text: "x ¼",
          list: pokemon.weakness.quarter,
          size: iconSize,
        ),
        Weak(
          text: "x ½",
          list: pokemon.weakness.half,
          size: iconSize,
        ),
        Weak(
          text: "x 0",
          list: pokemon.weakness.none,
          size: iconSize,
        ),
        Weak(
          text: "x 2",
          list: pokemon.weakness.double,
          size: iconSize,
        ),
        Weak(
          text: "x 4",
          list: pokemon.weakness.quadruple,
          size: iconSize,
        ),
      ],
    );
    return (MediaQuery.of(context).size.width < 1024)
        ? mainContent
        : DetailsCard(
            cardChild: Expanded(child: mainContent), blockTitle: "Weakness");
  }
}

class Weak extends StatelessWidget {
  const Weak({
    super.key,
    required this.text,
    required this.list,
    required this.size,
  });

  final String text;
  final List<dynamic> list;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.black12,
        child: Column(
          children: [
            SubTextDivider(text: text),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: list.map((item) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Pokemon.typeImage(
                        PokemonType.values.byName(item),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
            // Expanded(
            //   child: Center(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 8.0), // Adjust padding as needed
            //       child: Wrap(
            //         direction: Axis.horizontal,
            //         alignment: WrapAlignment.center,
            //         crossAxisAlignment: WrapCrossAlignment.center,
            //         children: list
            //             .map(
            //               (i) => FittedBox(
            //                 child: Padding(
            //                   padding:
            //                       const EdgeInsets.symmetric(horizontal: 5),
            //                   child: Pokemon.typeImage(
            //                     PokemonType.values.byName(i),
            //                   ),
            //                 ),
            //               ),
            //             )
            //             .toList(),
            //       ),
            //     ),
            //   ),
            // ),