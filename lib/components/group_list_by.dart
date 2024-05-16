import 'package:flutter/material.dart';
import '../models/enums.dart';

class GroupListBy extends StatelessWidget {
  const GroupListBy({
    required this.currentDisplay,
    required this.onDisplaySelected,
    super.key,
  });

  final CollectionDisplayType currentDisplay;
  final Function(CollectionDisplayType) onDisplaySelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Group By",
            style: TextStyle(color: Colors.white),
          )),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5,
          children: [
            TextButton(
              onPressed: () {
                onDisplaySelected(CollectionDisplayType.groupByPokemon);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber;
                  },
                ),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.blueGrey[800];
                  },
                ),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber[800];
                  },
                ),
              ),
              child: const Text("Pokemon"),
            ),
            TextButton(
              onPressed: () {
                onDisplaySelected(CollectionDisplayType.groupByCurrentGame);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber;
                  },
                ),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.blueGrey[800];
                  },
                ),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber[800];
                  },
                ),
              ),
              child: const Text("Current Game"),
            ),
            TextButton(
              onPressed: () {
                onDisplaySelected(CollectionDisplayType.groupByOriginalGame);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber;
                  },
                ),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.blueGrey[800];
                  },
                ),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber[800];
                  },
                ),
              ),
              child: const Text("Original Game"),
            ),
            TextButton(
              onPressed: () {
                onDisplaySelected(CollectionDisplayType.flatList);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber;
                  },
                ),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.blueGrey[800];
                  },
                ),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.amber[800];
                  },
                ),
              ),
              child: const Text("Show All"),
            ),
          ],
        ),
      ],
    );
  }
}
