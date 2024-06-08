import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_filter_button.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
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
    bool smallScreen = (PkmGrid.getCardsPerRow(context) == 1);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Group By",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (smallScreen) ? 15 : 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5,
          children: [
            PkmFilterButton(
              stretchBtn: true,
              condition:
                  (currentDisplay != CollectionDisplayType.groupByPokemon),
              onTap: () {
                onDisplaySelected(CollectionDisplayType.groupByPokemon);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: Text(
                  "Pokemon",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: (smallScreen) ? 15 : 20,
                  ),
                ),
              ),
            ),
            PkmFilterButton(
              stretchBtn: true,
              condition:
                  (currentDisplay != CollectionDisplayType.groupByCurrentGame),
              onTap: () {
                onDisplaySelected(CollectionDisplayType.groupByCurrentGame);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: Text(
                  "Current Game",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: (smallScreen) ? 15 : 20,
                  ),
                ),
              ),
            ),
            PkmFilterButton(
              stretchBtn: true,
              condition:
                  (currentDisplay != CollectionDisplayType.groupByOriginalGame),
              onTap: () {
                onDisplaySelected(CollectionDisplayType.groupByOriginalGame);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: Text(
                  "Original Game",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: (smallScreen) ? 15 : 20,
                  ),
                ),
              ),
            ),
            PkmFilterButton(
              stretchBtn: true,
              condition: (currentDisplay != CollectionDisplayType.flatList),
              onTap: () {
                onDisplaySelected(CollectionDisplayType.flatList);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: Text(
                  "Show All",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: (smallScreen) ? 15 : 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
