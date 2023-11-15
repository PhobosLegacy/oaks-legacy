import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import '../models/enums.dart';
import '../models/pokemon.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                //Shadow
                Center(
                  child: Image.network(
                    '${kImageLocalPrefix}mons/$imagePath',
                    color: Colors.black87,
                  ),
                ),
                //Image
                Center(
                  child: Image.network(
                    '${kImageLocalPrefix}mons/$imagePath',
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 5, child: Container())
        ],
      ),
    );
  }
}

class ListImage extends StatelessWidget {
  const ListImage({
    super.key,
    required this.image,
    this.shadowOnly,
  });

  final String image;
  final bool? shadowOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Stack(
        children: (shadowOnly == true)
            ? [
                getImage('$kImageLocalPrefix$image', 60, shadow: true),
              ]
            : [
                getImage('$kImageLocalPrefix$image', 60, shadow: true),
                getImage('$kImageLocalPrefix$image', 55),
              ],
      ),
    );
  }
}

class TrackerIcon extends StatelessWidget {
  const TrackerIcon({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return getImage('$kImageLocalPrefix$image', 50);
  }
}

getImage(String image, double size, {bool shadow = false}) {
  return Image.network(
    image,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          color: Colors.red,
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
    color: (shadow) ? Colors.black87 : null,
    height: size,
  );
}

class TypeIcon extends StatelessWidget {
  const TypeIcon(
      {super.key, required this.type, this.size, this.shadow = true});

  final PokemonType? type;
  final double? size;
  final bool? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (shadow == true)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset(2, 3),
                ),
              ],
            )
          : null,
      child: SizedBox(
        height: size,
        width: size,
        child: Pokemon.typeImage(type),
      ),
    );
  }
}
