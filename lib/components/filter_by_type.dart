import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
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
                  (item) => ZoomTapAnimation(
                    child: GestureDetector(
                      onTap: () {
                        (selectedTypes.contains(item.name))
                            ? selectedTypes.remove(item.name)
                            : selectedTypes.add(item.name);

                        if (selectedTypes.length > 2) {
                          selectedTypes.removeAt(0);
                        }

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
                                color: (!selectedTypes.contains(item.name))
                                    ? Colors.blueGrey[800]!
                                    : Colors.blueGrey[900]!,
                              ),
                              boxShadow: (!selectedTypes.contains(item.name))
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
                          child: TypeIcon(
                            type: PokemonType.values.byName(item.name),
                            size: 80,
                            shadow: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // (item) => ActionChip(
                  //   shape: const StadiumBorder(side: BorderSide()),
                  //   padding: const EdgeInsets.all(1),
                  //   backgroundColor: (selectedTypes.contains(item.name))
                  //       ? Colors.blueGrey[500]
                  //       : Colors.blueGrey[800],
                  //   shadowColor: Colors.white,
                  //   elevation: (selectedTypes.contains(item.name)) ? 10 : 0,
                  //   onPressed: () {
                  //     (selectedTypes.contains(item.name))
                  //         ? selectedTypes.remove(item.name)
                  //         : selectedTypes.add(item.name);

                  //     if (selectedTypes.length > 2) {
                  //       selectedTypes.removeAt(0);
                  //     }

                  //     onTypeSelected(selectedTypes);
                  //   },
                  //   label: TypeIcon(
                  //       type: PokemonType.values.byName(item.name),
                  //       size: 23,
                  //       shadow: false),
                  // ),
                )
                .toList()
                .cast<Widget>(),
          ),
        ),
      ],
    );
  }
}
