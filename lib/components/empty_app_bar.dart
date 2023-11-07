import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget {
  const EmptyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
