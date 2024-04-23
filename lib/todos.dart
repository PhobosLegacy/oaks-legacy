class Todos {
  Todos(this.listBase);
/*
GOOD TO KNOW
ON MAC, for web app, files are here: /Users/itorres/Library/Containers/com.example.protoDex/Data/Documents

To run on web and be able to connect with the mobile browser:
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 --debug --web-renderer canvaskit
 localhost:8080
 192.168.1.192:8080

Flutter Pub cache (to overwrite file_saver)
C:\Users\icaro\AppData\Local\Pub\Cache\hosted\pub.dev\file_saver-0.2.9\android\build.gradle

Icon to see 3 dots:
// IconButton(
//   icon: const Icon(Icons.more_vert),
//   onPressed: () {
//     setState(() {});
//   },
// ),

*************Previous Scrollbar implementation*************
// CustomScrollbar(
//   scrollController: scrollController,
//   child: ListView.builder(
//     controller: scrollController,
//     itemBuilder: ((context, index) {
//       return createCards(
//         originalPokedex,
//         [index],
//       );
//     }),
//     itemCount: originalPokedex.length,
//     shrinkWrap: false,
//     padding: const EdgeInsets.all(5),
//     scrollDirection: Axis.vertical,
//   ),
// ),
//This could be used if you want to keep the CustomScrollbar
// ListView pokedexListView({String? detailsKey,
//     Widget Function(List<Item>? items, List<int>? indexes)? pageBuilder}) {
//   return ListView.builder(
//     itemBuilder: ((context, index) {
//       return createCards(
//         kPokedex,
//         [index],
//         onStateChange: (pageBuilder != null)
//             ? (indexes) {
//                 List<Item> items = [
//                   createPlaceholderItem(indexes, detailsKey!)
//                 ];
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return pageBuilder(items, [0]);
//                     },
//                   ),
//                 );
//               }
//             : null,
//       );
//     }),
//     itemCount: kPokedex.length,
//     shrinkWrap: true,
//     padding: const EdgeInsets.all(5),
//     scrollDirection: Axis.vertical,
//   );
// }
*************Previous Scrollbar implementation*************

To check if a tracker is missing a number
  List<int> numbers =
      tracker.pokemons.map((tracker) => int.parse(tracker.number)).toList();
  List<int> missingNumbers = findMissingNumbers(numbers, 1, 242);

  if (missingNumbers.isEmpty) {
    print("No missing numbers found.");
  } else {
    print("Missing numbers: $missingNumbers");
  }
List<int> findMissingNumbers(List<int> numbersList, int start, int end) {
  Set<int> numbersSet = Set<int>.from(numbersList);
  List<int> missingNumbers = [];

  for (int i = start; i <= end; i++) {
    if (!numbersSet.contains(i)) {
      missingNumbers.add(i);
    }
  }

  return missingNumbers;
}

//Gets the resolution
/*
  bp1 (mobile) starts at 375dp
  bp2 (Tablet) starts at 768dp
  bp3 (Small "Desktop") start at 1024dp
  bp4 (Desktop) start at 1440 and up
*/
export const evaluateScreenSize = (width) => {
  switch (true) {
    case width < 768:
      return RESOLUTION.BP1;
    case width >= 768 && width < 1024:
      return RESOLUTION.BP2;
    case width >= 1024 && width < 1440:
      return RESOLUTION.BP3;
    case width >= 1440:
      return RESOLUTION.BP4;
  }
};

HOW TO PROPER USE BANNER AND CLIP THE RIGHT ELEMENT:
    // if (pokemon.game.notes.isNotEmpty) {
    //   content = ClipRRect(
    //     child: Card(
    //       color:
    //           (widget.isLowerTile) ? const Color(0xFF1D1E33) : Colors.black26,
    //       clipBehavior: Clip.antiAlias,
    //       child: Banner(
    //           message: pokemon.game.notes,
    //           location: BannerLocation.topEnd,
    //           color: getBannerColor(pokemon.game.notes),
    //           textStyle: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 9,
    //             fontWeight: FontWeight.bold,
    //           ),
    //           child: content),
    //     ),
    //   );
    // }

I accidently came over the solution. supabase.auth.exchangeCodeForSession(code)
Pass the code that comes along with the call and you get a session in return. Then the user is logged in.
    https://github.com/orgs/supabase/discussions/21317


Screenshot attempt by splitting image:

  // gridShot() async {
  //   int cardsPerRow = PkmGrid.getCardsPerRow(context);
  //   List<Item> screenshotLista = List<Item>.from(filteredList);

  //   // print('there are ${list.length} cards');
  //   // print('there are $cardsPerRow cards per row');

  //   // var rows = list.length ~/ cardsPerRow;
  //   // print('there are $rows rows');

  //   var otro = 99 ~/ cardsPerRow;
  //   // print('screenshot 1 will have $otro rows');

  //   for (var i = 0; i < filteredList.length; i) {
  //     var limit = ((i + otro * cardsPerRow) > filteredList.length)
  //         ? filteredList.length
  //         : i + otro * cardsPerRow;

  //     filteredList.clear();
  //     filteredList.addAll(screenshotLista.sublist(i, limit));

  //     print(
  //         'first index is ${filteredList.first.name} index ${filteredList.first.number}');
  //     print(
  //         'last index is ${filteredList.last.name} index ${filteredList.last.number}');
  //     Uint8List? imageBytes;
  //     try {
  //       imageBytes = await controller.capture();
  //       // imageBytes = await controller.captureFromWidget(screenshotList2());
  //     } catch (err) {
  //       print(err);
  //     }
  //     if (imageBytes == null) return;
  //     FileSaver.instance.saveFile(name: 'test.png', bytes: imageBytes);
  //     // //Trimmer
  //     // img.Image originalImage = img.decodeImage(imageBytes)!;
  //     // img.Image trimmedImage = img.trim(originalImage);
  //     // Uint8List trimmedImageBytes =
  //     //     Uint8List.fromList(img.encodePng(trimmedImage));
  //     // //END

  //     // final time = DateTime.now()
  //     //     .toIso8601String()
  //     //     .replaceAll('.', '-')
  //     //     .replaceAll(':', '-');

  //     // final name = 'pk_$time';

  //     // FileSaver.instance.saveFile(name: '$name.png', bytes: trimmedImageBytes);

  //     i = limit;

  //     filteredList.clear();
  //     filteredList.addAll(screenshotLista);
  //   }

  //   // showDialog(
  //   //   context: context,
  //   //   barrierColor: Colors.transparent,
  //   //   barrierDismissible: false,
  //   //   builder: (BuildContext dialogContext) {
  //   //     return Center(
  //   //       child: Container(
  //   //         padding: const EdgeInsets.all(16.0),
  //   //         decoration: BoxDecoration(
  //   //           color: Colors.white,
  //   //           borderRadius: BorderRadius.circular(10.0),
  //   //         ),
  //   //         child: const Text(
  //   //           "Hang On...",
  //   //           style: TextStyle(color: Colors.black, fontSize: 20),
  //   //         ),
  //   //       ),
  //   //     );
  //   //   },
  //   // );

  //   // Uint8List? imageBytes;

  //   // imageBytes = await screenshotController.capture();

  //   // if (imageBytes == null) return;

  //   // //Trimmer
  //   // img.Image originalImage = img.decodeImage(imageBytes)!;
  //   // img.Image trimmedImage = img.trim(originalImage);
  //   // Uint8List trimmedImageBytes =
  //   //     Uint8List.fromList(img.encodePng(trimmedImage));
  //   // //END

  //   // final time = DateTime.now()
  //   //     .toIso8601String()
  //   //     .replaceAll('.', '-')
  //   //     .replaceAll(':', '-');

  //   // final name = 'pk_$time';

  //   // if (kIsWeb) {
  //   //   FileSaver.instance.saveFile(name: '$name.png', bytes: trimmedImageBytes);
  //   // } else {
  //   //   await [Permission.storage].request();
  //   //   await ImageGallerySaver.saveImage(trimmedImageBytes, name: name);
  //   // }
  //   // if (context.mounted) Navigator.pop(context); // Close the loading modal
  // }
 */
  String listBase;
}
