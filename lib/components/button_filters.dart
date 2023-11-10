import 'package:flutter/material.dart';

class FiltersButton extends StatelessWidget {
  const FiltersButton({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.filter_alt_outlined,
        color: Colors.red,
      ),
      onPressed: () {
        scaffoldKey.currentState?.openEndDrawer();
      },
    );
  }
}
