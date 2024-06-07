import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oaks_legacy/components/pkm_filter_button.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import '../models/enums.dart';

class SortListBy extends StatelessWidget {
  const SortListBy({
    required this.onSortSelected,
    required this.currentFilters,
    super.key,
  });

  final Function(FilterType?) onSortSelected;
  final List<FilterType> currentFilters;

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
                "Sort By",
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
          children: [
            PkmFilterButton(
              condition: (!currentFilters.contains(FilterType.numAsc) &&
                  (currentFilters.contains(FilterType.numDesc) ||
                      currentFilters.contains(FilterType.nameAsc) ||
                      currentFilters.contains(FilterType.nameDesc))),
              onTap: () {
                (currentFilters.contains(FilterType.numAsc))
                    ? onSortSelected(null)
                    : onSortSelected(FilterType.numAsc);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowDown19,
                  color: Colors.amber,
                  size: (smallScreen) ? 30 : 50,
                ),
              ),
            ),
            PkmFilterButton(
              condition: (!currentFilters.contains(FilterType.numDesc)),
              onTap: () {
                (currentFilters.contains(FilterType.numDesc))
                    ? onSortSelected(null)
                    : onSortSelected(FilterType.numDesc);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowDown91,
                  color: Colors.amber,
                  size: (smallScreen) ? 30 : 50,
                ),
              ),
            ),
            PkmFilterButton(
              condition: (!currentFilters.contains(FilterType.nameAsc)),
              onTap: () {
                (currentFilters.contains(FilterType.nameAsc))
                    ? onSortSelected(null)
                    : onSortSelected(FilterType.nameAsc);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowDownAZ,
                  color: Colors.amber,
                  size: (smallScreen) ? 30 : 50,
                ),
              ),
            ),
            PkmFilterButton(
              condition: (!currentFilters.contains(FilterType.nameDesc)),
              onTap: () {
                (currentFilters.contains(FilterType.nameDesc))
                    ? onSortSelected(null)
                    : onSortSelected(FilterType.nameDesc);
              },
              smallScreen: smallScreen,
              btnContent: Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowDownZA,
                  color: Colors.amber,
                  size: (smallScreen) ? 30 : 50,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
