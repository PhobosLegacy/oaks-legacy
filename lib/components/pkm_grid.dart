import 'package:flutter/material.dart';

class PkmGrid extends StatefulWidget {
  const PkmGrid({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  State<PkmGrid> createState() => _PkmGridState();
}

class _PkmGridState extends State<PkmGrid> {
  @override
  build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    int cardsPerRow = currentWidth ~/ 400;
    if (cardsPerRow == 0) cardsPerRow = 1;

    return Expanded(
      child: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            // Adjust the cross axis count as needed
            crossAxisCount: cardsPerRow,
            // Adjust the height here
            childAspectRatio: (cardsPerRow == 1) ? 3 : 2,
          ),
          itemCount: widget.itemCount,
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}
