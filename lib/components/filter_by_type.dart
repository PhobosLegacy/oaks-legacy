import 'package:flutter/material.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "By Type",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: PokemonType.values
              .map((item) => ActionChip(
                    // shape: const RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.only(
                    //     topRight: Radius.circular(20),
                    //     bottomRight: Radius.circular(20),
                    //   ),
                    // ),
                    shape: const StadiumBorder(side: BorderSide()),
                    padding: const EdgeInsets.all(1),
                    backgroundColor: (selectedTypes.contains(item.name))
                        ? Colors.blueGrey[500]
                        : Colors.blueGrey[800],
                    shadowColor: Colors.white,
                    elevation: (selectedTypes.contains(item.name)) ? 10 : 0,
                    onPressed: () {
                      (selectedTypes.contains(item.name))
                          ? selectedTypes.remove(item.name)
                          : selectedTypes.add(item.name);

                      onTypeSelected(selectedTypes);
                    },
                    label: TypeIcon(
                        type: PokemonType.values.byName(item.name),
                        size: 23,
                        shadow: false),
                  ))
              .toList()
              .cast<Widget>(),
        ),
        Center(
          child: TextButton(
            onPressed: onClearPressed,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return Colors.amber;
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return Colors.blueGrey[800];
                },
              ),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return Colors.amber[800];
                },
              ),
            ),
            child: const Text(
              "Clear",
              // style: TextStyle(color: Colors.amber),
            ),
          ),
        )
      ],
    );
  }
}
