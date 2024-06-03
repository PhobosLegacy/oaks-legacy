import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
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
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  onDisplaySelected(CollectionDisplayType.groupByPokemon);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(5),
                    height: (smallScreen) ? 40 : 50,
                    width: 100,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (currentDisplay ==
                                  CollectionDisplayType.groupByPokemon)
                              ? Colors.blueGrey[800]!
                              : Colors.blueGrey[900]!,
                        ),
                        boxShadow: (currentDisplay !=
                                CollectionDisplayType.groupByPokemon)
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
                      child: Text(
                        "Pokemon",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: (smallScreen) ? 15 : 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  onDisplaySelected(CollectionDisplayType.groupByCurrentGame);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(5),
                    height: (smallScreen) ? 40 : 50,
                    width: (smallScreen) ? 120 : 150,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (currentDisplay ==
                                  CollectionDisplayType.groupByCurrentGame)
                              ? Colors.blueGrey[800]!
                              : Colors.blueGrey[900]!,
                        ),
                        boxShadow: (currentDisplay !=
                                CollectionDisplayType.groupByCurrentGame)
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
                      child: Text(
                        "Current Game",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: (smallScreen) ? 15 : 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  onDisplaySelected(CollectionDisplayType.groupByOriginalGame);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(5),
                    height: (smallScreen) ? 40 : 50,
                    width: (smallScreen) ? 120 : 150,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (currentDisplay ==
                                  CollectionDisplayType.groupByOriginalGame)
                              ? Colors.blueGrey[800]!
                              : Colors.blueGrey[900]!,
                        ),
                        boxShadow: (currentDisplay !=
                                CollectionDisplayType.groupByOriginalGame)
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
                      child: Text(
                        "Original Game",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: (smallScreen) ? 15 : 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ZoomTapAnimation(
              child: GestureDetector(
                onTap: () {
                  onDisplaySelected(CollectionDisplayType.flatList);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(5),
                    height: (smallScreen) ? 40 : 50,
                    width: (smallScreen) ? 120 : 150,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              (currentDisplay == CollectionDisplayType.flatList)
                                  ? Colors.blueGrey[800]!
                                  : Colors.blueGrey[900]!,
                        ),
                        boxShadow:
                            (currentDisplay != CollectionDisplayType.flatList)
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
                      child: Text(
                        "Show All",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: (smallScreen) ? 15 : 20,
                        ),
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
