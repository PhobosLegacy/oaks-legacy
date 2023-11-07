import 'package:flutter/material.dart';
import 'package:proto_dex/components/base_background.dart';
import '../models/enums.dart';
import '../models/pokemon.dart';

class TypeBackground extends StatelessWidget {
  const TypeBackground({super.key, required this.type1, this.type2});

  final PokemonType type1;
  final PokemonType? type2;

  List<Color> fillColors(PokemonType type1, PokemonType? type2) {
    List<Color> colors = <Color>[];

    colors.add(Pokemon.typeColor(type1, false));

    (type2 == null)
        ? colors.add(Pokemon.typeColor(type1, true))
        : colors.add(Pokemon.typeColor(type2, false));

    return colors.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: fillColors(type1, type2),
              ),
            ),
            child: const BaseBackground(),
          ),
        ),
      ],
    );
  }
}
