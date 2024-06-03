import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
              return ZoomTapAnimation(
                child: GestureDetector(
                  onTap: () {
                    (selectedTypes.contains((index + 1).toString()))
                        ? selectedTypes.remove((index + 1).toString())
                        : selectedTypes.add((index + 1).toString());

                    onTypeSelected(selectedTypes);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(5),
                      height: (smallScreen) ? 40 : 80,
                      width: (smallScreen) ? 40 : 80,
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              (!selectedTypes.contains((index + 1).toString()))
                                  ? Colors.blueGrey[800]!
                                  : Colors.blueGrey[900]!,
                        ),
                        boxShadow:
                            (!selectedTypes.contains((index + 1).toString()))
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
                                      offset: const Offset(-5, -5),
                                      blurRadius: 5,
                                      spreadRadius: 0.1,
                                    ),
                                  ],
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.amber,
                          ),
                        ),
                      ),
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
