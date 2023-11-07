import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';

class BaseBackground extends StatelessWidget {
  const BaseBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 2.5,
                alignment: Alignment.topLeft,
                image: const AssetImage(
                    '${kImagesRoot}background/ball_piece_4.png'),
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.modulate,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: const AssetImage(
                      '${kImagesRoot}background/ball_light.png'),
                  scale: 0.5,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2),
                    BlendMode.modulate,
                  ),
                ),
              ),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 2.5,
                    alignment: Alignment.bottomRight,
                    image: const AssetImage(
                        '${kImagesRoot}background/ball_piece.png'),
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.2),
                      BlendMode.modulate,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
