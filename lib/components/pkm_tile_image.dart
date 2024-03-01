import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/constants.dart';

class PkmTileImage extends StatelessWidget {
  const PkmTileImage({
    super.key,
    required this.image,
    required this.heroTag,
    this.shadowOnly,
    this.height,
  });

  final String image;
  final Object heroTag;
  final bool? shadowOnly;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: SizedBox(
        child: Stack(
          children: (shadowOnly == true)
              ? [
                  getImage('$kImageLocalPrefix$image', height ?? 200,
                      shadow: true),
                ]
              : [
                  getImage('$kImageLocalPrefix$image', height ?? 200,
                      shadow: true),
                  getImage('$kImageLocalPrefix$image', height ?? 195),
                ],
        ),
      ),
    );
  }
}
