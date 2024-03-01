import 'package:flutter/material.dart';

class PkmCheckbox extends StatefulWidget {
  const PkmCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.scale,
  });

  final Function(bool?)? onChanged;
  final bool value;
  final bool scale;

  @override
  State<PkmCheckbox> createState() => _PkmCheckbox();
}

class _PkmCheckbox extends State<PkmCheckbox> {
  @override
  Widget build(BuildContext context) {
    Widget checkbox = Checkbox(
      value: widget.value,
      onChanged: widget.onChanged,
    );
    return (widget.scale)
        ? Transform.scale(
            scale: 1.5,
            child: checkbox,
          )
        : checkbox;
  }
}
