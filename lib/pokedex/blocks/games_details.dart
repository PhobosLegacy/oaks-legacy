import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/components/image.dart';
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
    Widget mainContent = Card(
      color: Colors.black12,
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: ListImage(
                image: Game.gameIcon(pokemon.games[index].name),
              ),
              title: Text(
                pokemon.games[index].name,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              subtitle: Text(
                '(${pokemon.games[index].dex})',
                style: const TextStyle(
                  color: Colors.amber,
                ),
              ),
              trailing: Text(
                (pokemon.games[index].number == "")
                    ? ""
                    : '#${pokemon.games[index].number}',
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            );
          },
          itemCount: pokemon.games.length,
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
