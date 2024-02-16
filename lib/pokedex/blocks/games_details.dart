import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/pokemon.dart';

class GamesBlock extends StatelessWidget {
  const GamesBlock({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    var groupedGames = pokemon.games.groupListsBy((element) => element.name);

    List<Map<String, dynamic>> gameGroup = groupedGames.entries.map((entry) {
      return {
        'name': entry.key,
        'dexes': entry.value
            .map((game) => {'Name': game.dex, 'Number': game.number})
            .toList(),
      };
    }).toList();

    Widget mainContent = Card(
      color: Colors.black12,
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: Image.network(
                kImageLocalPrefix + Game.gameIcon(gameGroup[index]['name']),
                height: 40,
              ),
              title: Text(
                pokemon.games[index].name,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              children: [
                for (var dex in gameGroup[index]['dexes'])
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text(dex['Name']),
                  //     if (dex['Number'] != "")
                  //       Text('#${dex['Number']}')
                  //     else
                  //       Container(),
                  //   ],
                  // ),
                  ListTile(
                    title: Text(
                      dex['Name'],
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 15,
                      ),
                    ),
                    trailing: (dex['Number'] != "")
                        ? Text(
                            '#${dex['Number']}',
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : const SizedBox(),
                  ),
              ],
            );

            // return Padding(
            //   padding: const EdgeInsets.all(3.0),
            //   child: Container(
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(2.0),
            //           child: ListImage(
            //             image: Game.gameIcon(pokemon.games[index].name),
            //             height: 60,
            //           ),
            //         ),
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             children: [
            //               Text(
            //                 pokemon.games[index].name,
            //                 style: const TextStyle(
            //                     color: Colors.white, fontSize: 15),
            //               ),
            //               Text(
            //                 '[${pokemon.games[index].dex}]',
            //                 style: const TextStyle(
            //                     color: Colors.amber, fontSize: 12),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Text(
            //           (pokemon.games[index].number == "")
            //               ? ""
            //               : '#${pokemon.games[index].number}',
            //           style: const TextStyle(color: Colors.white, fontSize: 15),
            //         ),
            //       ],
            //     ),
            //   ),
            // );

            // return ListTile(
            //   leading: ListImage(
            //     image: Game.gameIcon(pokemon.games[index].name),
            //   ),
            //   title: Text(
            //     pokemon.games[index].name,
            //     style: const TextStyle(color: Colors.white, fontSize: 15),
            //   ),
            //   subtitle: Text(
            //     '(${pokemon.games[index].dex})',
            //     style: const TextStyle(
            //       color: Colors.amber,
            //     ),
            //   ),
            //   trailing: Text(
            //     (pokemon.games[index].number == "")
            //         ? ""
            //         : '#${pokemon.games[index].number}',
            //     style: const TextStyle(color: Colors.white, fontSize: 15),
            //   ),
            // );
          },
          // itemCount: pokemon.games.length,
          itemCount: gameGroup.length,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
    return (MediaQuery.of(context).size.width < 1024)
        ? mainContent
        : DetailsCard(
            cardChild: Expanded(child: mainContent), blockTitle: "Games");
  }
}
