import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/image.dart';
import '../../components/basic.dart';
import '../../models/enums.dart';
import '../../models/pokemon.dart';

class WeaknessInformationCard extends StatelessWidget {
  const WeaknessInformationCard({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "Weakness",
      cardChild: Expanded(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (pokemon.weakness.quarter.isNotEmpty)
              const SubTextDivider(text: "x ¼"),
            IconList(list: pokemon.weakness.quarter),
            if (pokemon.weakness.half.isNotEmpty)
              const SubTextDivider(text: "x ½"),
            IconList(list: pokemon.weakness.half),
            if (pokemon.weakness.none.isNotEmpty)
              const SubTextDivider(text: "x 0"),
            IconList(list: pokemon.weakness.none),
            if (pokemon.weakness.double.isNotEmpty)
              const SubTextDivider(text: " x2"),
            IconList(list: pokemon.weakness.double),
            if (pokemon.weakness.quadruple.isNotEmpty)
              const SubTextDivider(text: " x4"),
            IconList(list: pokemon.weakness.quadruple),
          ],
        ),
      ),
    );
  }
}

class IconList extends StatelessWidget {
  const IconList({
    super.key,
    required this.list,
  });

  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: list
          .map(
            (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TypeIcon(
                type: (PokemonType.values.byName(i)),
                size: 21, //(list.length > 4) ? 15 : 22,
              ),
            ),
          )
          .toList(),
    );
  }
}
