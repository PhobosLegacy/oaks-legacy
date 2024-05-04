import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_scrollbar.dart';

class PkmGrid extends StatefulWidget {
  const PkmGrid({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  State<PkmGrid> createState() => _PkmGridState();

  static getCardsPerRow(context) {
    double currentWidth = MediaQuery.of(context).size.width;
    int cardsPerRow = currentWidth ~/ 400;
    if (cardsPerRow == 0) cardsPerRow = 1;

    return cardsPerRow;
  }
}

final ScrollController scrollController = ScrollController();

class _PkmGridState extends State<PkmGrid> {
  @override
  build(BuildContext context) {
    int cardsPerRow = PkmGrid.getCardsPerRow(context);

    return PkmScrollbar(
      scrollController: scrollController,
      child: Center(
        child: GridView.builder(
          shrinkWrap: true,
          controller: scrollController,
          // physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            // Adjust the cross axis count as needed
            crossAxisCount: cardsPerRow,
            // Adjust the height here
            childAspectRatio: (cardsPerRow == 1) ? 3 : 2,
          ),
          itemCount: widget.itemCount,
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}
// class _PkmGridState extends State<PkmGrid> {
//   @override
//   build(BuildContext context) {
//     int cardsPerRow = PkmGrid.getCardsPerRow(context);

//     return RawScrollbar(
//       controller: scrollController,
//       thumbColor: Colors.red, // set thumb color to transparent
//       thumbVisibility: true,
//       minThumbLength: 50,
//       radius: Radius.circular(10),
//       trackColor: Colors.amber,
//       trackVisibility: true,
//       thickness: 20,
//       child: CustomScrollView(
//         controller: scrollController,
//         slivers: [
//           SliverPadding(
//             padding: const EdgeInsets.all(8.0),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: cardsPerRow,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 5,
//                 childAspectRatio: (cardsPerRow == 1) ? 3 : 2,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 widget.itemBuilder,
//                 childCount: widget.itemCount,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// double currentWidth = MediaQuery.of(context).size.width;
// int cardsPerRow = currentWidth ~/ 400;
// if (cardsPerRow == 0) cardsPerRow = 1;
// return CustomScrollbar(
//   scrollController: ScrollController(),
//   child: GridView.builder(
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: cardsPerRow,
//       crossAxisSpacing: 5,
//       mainAxisSpacing: 5,
//       childAspectRatio: (cardsPerRow == 1) ? 3 : 2,
//     ),
//     itemBuilder: widget.itemBuilder,
//     itemCount: widget.itemCount,
//     shrinkWrap: true, // Ensures the ListView doesn't take extra space
//   ),
// );
// return Center(
//   child: GridView.builder(
//     shrinkWrap: true,
//     // physics: const NeverScrollableScrollPhysics(),
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisSpacing: 5,
//       mainAxisSpacing: 5,
//       // Adjust the cross axis count as needed
//       crossAxisCount: cardsPerRow,
//       // Adjust the height here
//       childAspectRatio: (cardsPerRow == 1) ? 3 : 2,
//     ),
//     itemCount: widget.itemCount,
//     itemBuilder: widget.itemBuilder,
//   ),
// );