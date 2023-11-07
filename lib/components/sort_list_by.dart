import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/enums.dart';

class SortListBy extends StatelessWidget {
  const SortListBy({
    required this.onFilterSelected,
    super.key,
  });

  final Function(FilterType) onFilterSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Sort By",
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextButton(
              child: const FaIcon(
                FontAwesomeIcons.arrowDown19,
                color: Colors.amber,
              ),
              onPressed: () {
                onFilterSelected(FilterType.numAsc);
              },
            ),
            TextButton(
              child: const FaIcon(
                FontAwesomeIcons.arrowDown91,
                color: Colors.amber,
              ),
              onPressed: () {
                onFilterSelected(FilterType.numDesc);
              },
            ),
            TextButton(
              child: const FaIcon(
                FontAwesomeIcons.arrowDownAZ,
                color: Colors.amber,
              ),
              onPressed: () {
                onFilterSelected(FilterType.nameAsc);
              },
            ),
            TextButton(
              child: const FaIcon(
                FontAwesomeIcons.arrowDownZA,
                color: Colors.amber,
              ),
              onPressed: () {
                onFilterSelected(FilterType.nameDesc);
              },
            ),
          ],
        ),
      ],
    );
  }
}
