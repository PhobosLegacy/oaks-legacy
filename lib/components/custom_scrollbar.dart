import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

class CustomScrollbar extends StatelessWidget {
  const CustomScrollbar({
    super.key,
    required this.scrollController,
    required this.child,
  });

  final ScrollController scrollController;
  final BoxScrollView child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DraggableScrollbar(
        heightScrollThumb: 50.0,
        scrollThumbBuilder: (
          Color backgroundColor,
          Animation<double> thumbAnimation,
          Animation<double> labelAnimation,
          double height, {
          Text? labelText,
          BoxConstraints? labelConstraints,
        }) {
          return FadeTransition(
            opacity: thumbAnimation,
            child: CustomPaint(
              foregroundPainter: ArrowCustomPainter(Colors.white),
              child: Container(
                constraints: BoxConstraints.tight(Size(45 * 0.6, height)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height),
                    bottomLeft: Radius.circular(height),
                    topRight: const Radius.circular(4.0),
                    bottomRight: const Radius.circular(4.0),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red,
                      Colors.black,
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.white,
        controller: scrollController,
        child: child,
      ),
    );
  }
}
