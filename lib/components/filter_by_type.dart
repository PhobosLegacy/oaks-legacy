import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_filter_button.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import '../models/enums.dart';
import 'image.dart';

class FilterByType extends StatelessWidget {
  const FilterByType({
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
                "By Type",
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
            children: PokemonType.values
                .map(
                  (item) => PkmFilterButton(
                    condition: (!selectedTypes.contains(item.name)),
                    onTap: () {
                      (selectedTypes.contains(item.name))
                          ? selectedTypes.remove(item.name)
                          : selectedTypes.add(item.name);

                      if (selectedTypes.length > 2) {
                        selectedTypes.removeAt(0);
                      }

                      onTypeSelected(selectedTypes);
                    },
                    smallScreen: smallScreen,
                    btnContent: Center(
                        child: TypeIcon(
                      type: PokemonType.values.byName(item.name),
                      size: 80,
                      shadow: false,
                    )),
                  ),
                )
                .toList()
                .cast<Widget>(),
          ),
        ),
      ],
    );
  }
}
