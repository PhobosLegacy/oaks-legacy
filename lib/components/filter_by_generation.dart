import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_filter_button.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/utils/extensions.dart';

class FilterByGeneration extends StatelessWidget {
  const FilterByGeneration({
    super.key,
    required this.selectedTypes,
    required this.onTypeSelected,
    required this.onClearPressed,
  });

  final List<String> selectedTypes;
  final Function(List<String> list) onTypeSelected;
  final Function() onClearPressed;

  @override
  Widget build(BuildContext context) {
    bool smallScreen = (PkmGrid.getCardsPerRow(context) == 1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "By Generation",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (smallScreen) ? 15 : 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
              IconButton(
                onPressed: onClearPressed,
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: (smallScreen) ? 20 : 30,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(9, (index) {
              return PkmFilterButton(
                condition: (!selectedTypes.contains((index + 1).toString())),
                onTap: () {
                  (selectedTypes.contains((index + 1).toString()))
                      ? selectedTypes.remove((index + 1).toString())
                      : selectedTypes.add((index + 1).toString());

                  onTypeSelected(selectedTypes);
                },
                smallScreen: smallScreen,
                btnContent: Center(
                  child: Text(
                    index.getRomanNumber(),
                    style: TextStyle(
                      fontSize: (smallScreen) ? 20 : 40,
                      color: Colors.amber,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
