import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/constants.dart';

class PkmImage extends StatelessWidget {
  const PkmImage({
    super.key,
    required this.image,
    required this.heroTag,
    this.shadowOnly,
    this.height = 600,
  });

  final String image;
  final Object heroTag;
  final bool? shadowOnly;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: SizedBox(
        child: Stack(
          children: (shadowOnly == true)
              ? [
                  getImage('$kImageLocalPrefix$image', height, shadow: true),
                ]
              : [
                  getImage('$kImageLocalPrefix$image', height, shadow: true),
                  getImage('$kImageLocalPrefix$image', height - 5),
                ],
        ),
      ),
    );
  }
}
