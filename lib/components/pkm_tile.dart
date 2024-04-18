import 'package:flutter/material.dart';

class PkmTile extends StatefulWidget {
  const PkmTile({
    super.key,
    required this.desktopContent,
    required this.mobileContent,
    required this.onTap,
    this.onLongPress,
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
          color: Colors.amber,
          // (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
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

class PkmOption extends StatefulWidget {
  const PkmOption({
    super.key,
    required this.onTap,
    required this.content,
  });

  final void Function()? onTap;
  final Widget content;

  @override
  State<PkmOption> createState() => _PkmOption();
}

class _PkmOption extends State<PkmOption> {
  bool isHovered = false;

  void onEntered(isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    var stack = MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform.translate(
          offset: isHovered ? const Offset(1, -10) : const Offset(1, 1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF1D1E33),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white38,
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: const Color(0xFF1D1E33),
              elevation: 10,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  widget.content,
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return stack;
  }
}
