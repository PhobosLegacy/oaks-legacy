import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  (currentFilters.contains(FilterType.numAsc))
                      ? onSortSelected(null)
                      : onSortSelected(FilterType.numAsc);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(5),
                    height: (smallScreen) ? 50 : 80,
                    width: (smallScreen) ? 50 : 80,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (!currentFilters.contains(FilterType.numAsc) &&
                                  (currentFilters
                                          .contains(FilterType.numDesc) ||
                                      currentFilters
                                          .contains(FilterType.nameAsc) ||
                                      currentFilters
                                          .contains(FilterType.nameDesc)))
                              ? Colors.blueGrey[800]!
                              : Colors.blueGrey[900]!,
                        ),
                        boxShadow: (!currentFilters
                                    .contains(FilterType.numAsc) &&
                                (currentFilters.contains(FilterType.numDesc) ||
                                    currentFilters
                                        .contains(FilterType.nameAsc) ||
                                    currentFilters
                                        .contains(FilterType.nameDesc)))
                            ? []
                            : [
                                const BoxShadow(
                                  color: Colors.amber,
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                  spreadRadius: 0.1,
                                ),
                                BoxShadow(
                                  color: Colors.blueGrey[800]!,
                                  offset: Offset(-5, -5),
                                  blurRadius: 5,
                                  spreadRadius: 0.1,
                                ),
                              ]),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowDown19,
                        color: Colors.amber,
                        size: (smallScreen) ? 30 : 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  (currentFilters.contains(FilterType.numDesc))
                      ? onSortSelected(null)
                      : onSortSelected(FilterType.numDesc);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(5),
                    height: (smallScreen) ? 50 : 80,
                    width: (smallScreen) ? 50 : 80,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (!currentFilters.contains(FilterType.numDesc))
                              ? Colors.blueGrey[800]!
                              : Colors.blueGrey[900]!,
                        ),
                        boxShadow:
                            (!currentFilters.contains(FilterType.numDesc))
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.amber,
                                      offset: const Offset(5, 5),
                                      blurRadius: 5,
                                      spreadRadius: 0.1,
                                    ),
                                    BoxShadow(
                                      color: Colors.blueGrey[800]!,
                                      offset: Offset(-5, -5),
                                      blurRadius: 5,
                                      spreadRadius: 0.1,
                                    ),
                                  ]),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowDown91,
                        color: Colors.amber,
                        size: (smallScreen) ? 30 : 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  (currentFilters.contains(FilterType.nameAsc))
                      ? onSortSelected(null)
                      : onSortSelected(FilterType.nameAsc);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(5),
                    height: (smallScreen) ? 50 : 80,
                    width: (smallScreen) ? 50 : 80,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (!currentFilters.contains(FilterType.nameAsc))
                              ? Colors.blueGrey[800]!
                              : Colors.blueGrey[900]!,
                        ),
                        boxShadow:
                            (!currentFilters.contains(FilterType.nameAsc))
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.amber,
                                      offset: const Offset(5, 5),
                                      blurRadius: 5,
                                      spreadRadius: 0.1,
                                    ),
                                    BoxShadow(
                                      color: Colors.blueGrey[800]!,
                                      offset: Offset(-5, -5),
                                      blurRadius: 5,
                                      spreadRadius: 0.1,
                                    ),
                                  ]),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowDownAZ,
                        color: Colors.amber,
                        size: (smallScreen) ? 30 : 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  (currentFilters.contains(FilterType.nameDesc))
                      ? onSortSelected(null)
                      : onSortSelected(FilterType.nameDesc);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(5),
                    height: (smallScreen) ? 50 : 80,
                    width: (smallScreen) ? 50 : 80,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (!currentFilters.contains(FilterType.nameDesc))
                              ? Colors.blueGrey[800]!
                              : Colors.blueGrey[900]!,
                        ),
                        boxShadow:
                            (!currentFilters.contains(FilterType.nameDesc))
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.amber,
                                      offset: const Offset(5, 5),
                                      blurRadius: 5,
                                      spreadRadius: 0.1,
                                    ),
                                    BoxShadow(
                                      color: Colors.blueGrey[800]!,
                                      offset: Offset(-5, -5),
                                      blurRadius: 5,
                                      spreadRadius: 0.1,
                                    ),
                                  ]),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowDownZA,
                        color: Colors.amber,
                        size: (smallScreen) ? 30 : 50,
                      ),
                    ),
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
