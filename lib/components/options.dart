import 'package:flutter/material.dart';

class ShowOptions extends StatelessWidget {
  const ShowOptions({
    super.key,
    // this.onOptionSelected,
    required this.items,
  });

  // final Function(dynamic)? onOptionSelected;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 400;

    Widget children = Center(
      child: Wrap(
        spacing: 50,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: items,
      ),
    );

    children = (isSmallScreen)
        ? SingleChildScrollView(
            child: children,
          )
        : children;

    return Column(children: [
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          iconSize: 50,
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ),
      Expanded(child: children)
    ]);
  }
}
