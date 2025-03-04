import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/disclaimer.dart';
import 'package:oaks_legacy/components/main_button.dart';
import 'package:oaks_legacy/components/pkm_contact.dart';
import 'package:oaks_legacy/components/pkm_donate.dart';
import 'package:oaks_legacy/components/pkm_login.dart';
import 'package:oaks_legacy/components/pkm_news.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/item/item_list_screen.dart';
import 'package:oaks_legacy/pokedex/pokedex_list_screen.dart';
import 'package:oaks_legacy/screens/your_trackers.dart';
import 'preferences_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BaseBackground(),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: [
                MainScreenButton(
                  title: 'Pokedex',
                  subtitle: 'Check data of all Pokemon!',
                  image: 'main/mew.png',
                  screen: PokedexListScreen(pokemons: kPokedex),
                ),
                const MainScreenButton(
                  title: 'Collection',
                  subtitle: 'See and edit your collection.',
                  image: 'main/pikachu.png',
                  screen: CollectionScreen(),
                ),
                const MainScreenButton(
                  title: 'Trackers',
                  subtitle: 'Track your progress through game pokedex!',
                  image: 'main/eevee.png',
                  screen: YourTrackersScreen(),
                ),
                const MainScreenButton(
                  title: 'Looking For',
                  subtitle: 'Make a list of the pokemon you are looking for.',
                  image: 'main/bulbasaur.png',
                  screen: LookingForScreen(),
                ),
                const MainScreenButton(
                  title: 'For Trade',
                  subtitle: 'Show everyone what you have for trade!',
                  image: 'main/charmander.png',
                  screen: ForTradeScreen(),
                ),
                const MainScreenButton(
                  title: 'Settings',
                  subtitle: 'Set up trainer names and other configs',
                  image: 'main/squirtle.png',
                  screen: PreferencesScreen(),
                ),
              ],
            ),
          ),
          PkmAccountIcon(
            callBack: () => setState(() {}),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (kFlags.displayNews) const PkmNewsIcon(),
              if (loggedUserId != '' && kFlags.displayContactUs)
                const PkmContactIcon(),
              if (kFlags.displayDonate) const PkmDonateIcon(),
            ],
          ),
          const Disclaimer(),
        ],
      ),
    );
  }
}
