// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/models/preferences.dart';
import 'package:oaks_legacy/models/version.dart';
import 'package:oaks_legacy/file_manager.dart';
import 'package:oaks_legacy/models/pokemon.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:http/http.dart' as http;
import 'package:oaks_legacy/screens/start_screen.dart';
import 'package:oaks_legacy/screens/your_trackers.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    loadFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BaseBackground(),
          Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                fontSize: 30,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void loadFiles() async {
  //   await FileManager.loadPreferences();

  //   //********* Resolve Versions file *********\\
  //   Data localData = Data.fromJson(jsonDecode(FileManager.get(kVersionsKey)));

  //   FileManager.save(kVersionsKey, jsonEncode(localData));
  //   //***************************************\\

  //   //********* Resolve Preferences file *********\\
  //   kPreferences =
  //       Preferences.fromJson(jsonDecode(FileManager.get(kPreferencesKey)));

  //   FileManager.save(kPreferencesKey, jsonEncode(kPreferences));
  //   //***************************************\\

  //   //********* Resolve Pokedex file *********\\
  //   String pokedex = FileManager.get(kPokedexKey);

  //   FileManager.save(kPokedexKey, pokedex);
  //   //***************************************\\

  //   //For debugging:
  //   var file = await rootBundle.loadString(kPokedexFileLocation);
  //   kPokedex = await Pokemon.createPokedex(file);
  //   // kPokedex = await Pokemon.createPokedex(pokedex);

  //   // await Future.delayed(const Duration(seconds: 2));
  //   // openStartScreen(const MaintainanceScreen());
  //   openStartScreen(const StartScreen());
  //   // openStartScreen(PokedexDetailsPage(
  //   //   pokemons: kPokedex,
  //   //   indexes: const [0],
  //   // ));
  // }

  void loadFiles() async {
    await FileManager.loadPreferences();
    // FileManager.removeAllKeys();
    Data serverData =
        Data.fromJson(jsonDecode(await fetchData(kServerVersionLocation)));

    // bool checkVersioning = true;

    //********* Resolve Versions file *********\\
    Data localData = (FileManager.exists(kVersionsKey))
        ? Data.fromJson(jsonDecode(FileManager.get(kVersionsKey)))
        : serverData;

    FileManager.save(kVersionsKey, jsonEncode(localData));
    //***************************************\\

    //********* Resolve Preferences file *********\\
    kPreferences = (FileManager.exists(kPreferencesKey))
        ? Preferences.fromJson(jsonDecode(FileManager.get(kPreferencesKey)))
        : Preferences.fromJson(jsonDecode(await fetchData(kServerPreferences)));

    FileManager.save(kPreferencesKey, jsonEncode(kPreferences));
    //***************************************\\

    //********* Resolve Pokedex file *********\\
    String pokedex = await fetchData(kServerPokedexLocation);
    //***************************************\\

    //For debugging:
    // var file = await rootBundle.loadString(kPokedexFileLocation);
    // kPokedex = await Pokemon.createPokedex(file);
    kPokedex = await Pokemon.createPokedex(pokedex);

    // await Future.delayed(const Duration(seconds: 2));
    // openNextScreen(const MaintainanceScreen());
    openNextScreen(const StartScreen());

    // openNextScreen(const YourTrackersScreen());
    // kPokedex = kPokedex
    //     .where((element) =>
    //         element.name == "Sandslash" || element.name == "Tauros")
    //     .toList();
    // openNextScreen(PokedexDetailsPage(
    //   pokemons: kPokedex,
    //   indexes: const [24, 0],
    // ));
    // openNextScreen(PokedexListScreen(pokemons: kPokedex));
    // openNextScreen(const TestListScreen6());

    // openNextScreen(PokedexDetailsPage(
    //   pokemons: kPokedex,
    //   indexes: const [0],
    // ));
  }

  Future<String> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load server version');
    }
  }

  void displayUpdateAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Wait!'),
        content: const Text(
            "There's a new version available. You should probably get it!"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void openNextScreen(screen) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }
}
