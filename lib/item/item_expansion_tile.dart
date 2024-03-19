// import 'package:flutter/material.dart';
// import 'package:oaks_legacy/item/item_tile.dart';
// import '../../components/image.dart';
// import '../../models/group.dart';
// import '../models/item.dart';

// Widget createCards(
//   Group group, {
//   Function(Item)? onStateChange,
//   Function(Item)? onDelete,
//   subLevel = false,
// }) {
//   final GlobalKey expansionTileKey = GlobalKey();

//   void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
//     final keyContext = expansionTileKey.currentContext;
//     if (keyContext != null) {
//       Future.delayed(const Duration(milliseconds: 240)).then((value) {
//         Scrollable.ensureVisible(keyContext,
//             duration: const Duration(milliseconds: 200));
//       });
//     }
//   }

//   return Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     clipBehavior: Clip.antiAlias,
//     child: ExpansionTile(
//       key: expansionTileKey,
//       onExpansionChanged: (value) {
//         if (value) {
//           scrollToSelectedContent(expansionTileKey: expansionTileKey);
//         }
//       },
//       collapsedBackgroundColor:
//           (group.color == null) ? Colors.black26 : group.color,
//       backgroundColor: (group.color == null) ? Colors.black26 : group.color,
//       leading: ListImage(
//         image: group.image,
//       ),
//       title: Text(
//         group.name,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//       trailing: Text(
//         '+${group.items.length}',
//         style: const TextStyle(
//           fontStyle: FontStyle.italic,
//           color: Colors.black,
//         ),
//       ),
//       children: [
//         ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index2) {
//             return ItemTile(
//               pokemons: group.items,
//               indexes: [index2],
//               onStateChange: onStateChange,
//               onDelete: onDelete,
//             );
//           },
//           itemCount: group.items.length,
//           shrinkWrap: true,
//           padding: const EdgeInsets.all(5),
//           scrollDirection: Axis.vertical,
//         )
//       ],
//     ),
//   );
// }
