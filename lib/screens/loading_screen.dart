import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proto_dex/components/base_background.dart';
import 'package:proto_dex/models/preferences.dart';
import 'package:proto_dex/models/version.dart';
import 'start_screen.dart';
import 'package:proto_dex/file_manager.dart';
import 'package:proto_dex/models/pokemon.dart';
import 'package:proto_dex/constants.dart';
import 'package:http/http.dart' as http;

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

  void loadFiles() async {
    await FileManager.loadPreferences();
    // FileManager.removeAllKeys();
    Data serverData =
        Data.fromJson(jsonDecode(await fetchData(kServerVersionLocation)));

    bool checkVersioning = true;

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
    String pokedex = (FileManager.exists(kPokedexKey))
        ? FileManager.get(kPokedexKey)
        : await fetchData(kServerPokedexLocation);

    FileManager.save(kPokedexKey, pokedex);
    //***************************************\\

    if (serverData.app > localData.app) {
      displayUpdateAlert();
      checkVersioning = false;
    }

    if (checkVersioning) {
      if (serverData.dex > localData.dex) {
        pokedex = await fetchData(kServerPokedexLocation);

        localData.dex = serverData.dex;
        FileManager.save(kVersionsKey, jsonEncode(localData));
      }
    }

    //For debugging:
    // var file = await rootBundle.loadString(kPokedexFileLocation);
    // kPokedex = await Pokemon.createPokedex(file);

    kPokedex = await Pokemon.createPokedex(pokedex);
    // await Future.delayed(const Duration(seconds: 2));
    openStartScreen();
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

  void openStartScreen() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const StartScreen();
        },
      ),
    );
  }
}
