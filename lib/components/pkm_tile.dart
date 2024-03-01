import 'package:flutter/material.dart';

class PkmTile extends StatefulWidget {
  const PkmTile({
    super.key,
    required this.desktopContent,
    required this.mobileContent,
    required this.onTap,
    required this.onLongPress,
    this.isLowerTile = false,
  });

  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget desktopContent;
  final Widget mobileContent;
  final bool isLowerTile;

  @override
  State<PkmTile> createState() => _PkmTile();
}

class _PkmTile extends State<PkmTile> {
  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    int cardsPerRow = currentWidth ~/ 400;
    double width = currentWidth / cardsPerRow - 12.0;
    double height = (cardsPerRow > 1) ? 220 : 110;

    var stack = GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Card(
          color:
              (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
          clipBehavior: Clip.antiAlias,
          child:
              (cardsPerRow > 1) ? widget.desktopContent : widget.mobileContent),
    );

    return SizedBox(
        width: (widget.isLowerTile) ? width * 0.9 : width,
        height: (widget.isLowerTile) ? height * 0.9 : height,
        child: stack);
  }
}
