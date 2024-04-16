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
 */
  String listBase;
}
