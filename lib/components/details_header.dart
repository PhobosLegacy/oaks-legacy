import 'package:flutter/material.dart';
import 'package:proto_dex/components/image.dart';
import 'package:proto_dex/models/enums.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader(
      {super.key,
      required this.name,
      required this.number,
      required this.type1,
      required this.type2,
      this.displayNumber = false});

  // final Pokemon pokemon;
  final String name;
  final String number;
  final PokemonType type1;
  final PokemonType? type2;
  final bool displayNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Text(
                  overflow: TextOverflow.fade,
                  name,
                  style: const TextStyle(
                    fontFamily: 'SigmarOne',
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  softWrap: true,
                ),
              ),
              if (displayNumber && number.isNotEmpty)
                Text(
                  "#$number",
                  style: const TextStyle(
                    fontFamily: 'SigmarOne',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
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
