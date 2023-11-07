import 'package:flutter/material.dart';
import 'package:proto_dex/components/base_background.dart';
import 'package:proto_dex/components/disclaimer.dart';
import 'package:proto_dex/components/main_button.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/collection/collection_list_screen.dart';
import 'package:proto_dex/fortrade/fortrade_list_screen.dart';
import 'package:proto_dex/pokedex/pokedex_list_screen.dart';
import 'preferences_screen.dart';
import 'package:proto_dex/screens/select_tracker_screen.dart';
import 'package:proto_dex/lookingfor/lookingfor_list_screen.dart';

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
        children: <Widget>[
          const BaseBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainScreenButton(
                    name: 'Pokedex',
                    image: 'main/mew.png',
                    screen: PokedexListScreen(pokemons: kPokedex),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainScreenButton(
                    name: 'Collection',
                    image: 'main/pikachu.png',
                    screen: CollectionScreen(),
                  ),
                  MainScreenButton(
                    name: 'Trackers',
                    image: 'main/eevee.png',
                    screen: SelectTrackerScreen(),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainScreenButton(
                    name: 'Looking For',
                    image: 'main/bulbasaur.png',
                    screen: LookingForScreen(),
                  ),
                  MainScreenButton(
                    name: 'For Trade',
                    image: 'main/charmander.png',
                    screen: ForTradeScreen(),
                  ),
                  MainScreenButton(
                    name: 'Settings',
                    image: 'main/squirtle.png',
                    screen: PreferencesScreen(),
                  ),
                ],
              ),
            ],
          ),
          const Disclaimer(),
        ],
      ),
    );
  }
}
