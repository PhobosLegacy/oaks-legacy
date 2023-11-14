import 'package:flutter/material.dart';
import 'package:proto_dex/components/image.dart';
import 'package:proto_dex/models/enums.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    super.key,
    required this.type1,
    required this.type2,
  });

  // final Pokemon pokemon;
  final PokemonType type1;
  final PokemonType? type2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Column(
        children: [
          const Divider(thickness: 2, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TypeIcon(
                type: type1,
                size: 60,
              ),
              if (type2 != null)
                TypeIcon(
                  type: type2,
                  size: 60,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
