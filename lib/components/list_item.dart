import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/tracker/tracker_tiles.dart';
import '/models/item.dart';

class ItemList extends StatefulWidget {
  const ItemList({
    super.key,
    required this.pokemons,
    required this.callBackAction,
    this.pageBuilder,
  });

  final List<Item> pokemons;
  final VoidCallback callBackAction;
  final Widget Function(List<Item> items, List<int> indexes)? pageBuilder;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  build(BuildContext context) {
    return PkmGrid(
      itemBuilder: (context, index) {
        return TrackerTile(
          pokemons: widget.pokemons,
          indexes: [index],
          isLowerTile: false,
          onStateChange: () {
            widget.callBackAction();
          },
        );
      },
      itemCount: widget.pokemons.length,
    );
  }
}


// class _ItemListState extends State<ItemList> {
//   @override
//   build(BuildContext context) {
//     double currentWidth = MediaQuery.of(context).size.width;
//     int cardsPerRow = currentWidth ~/ 400;
//     if (cardsPerRow == 0) cardsPerRow = 1;

//     return Expanded(
//       child: Center(
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 5,
//             // Adjust the cross axis count as needed
//             crossAxisCount: cardsPerRow,
//             // Adjust the height here
//             childAspectRatio: (cardsPerRow == 1) ? 3 : 2,
//           ),
//           itemCount: widget.pokemons.length,
//           itemBuilder: (context, index) {
//             return TrackerTile(
//               pokemons: widget.pokemons,
//               indexes: [index],
//               isLowerTile: false,
//               onStateChange: () {
//                 widget.callBackAction();
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
