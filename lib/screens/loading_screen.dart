// ignore_for_file: unused_import
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:oaks_legacy/utils/colors.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/pkm_login.dart';
import 'package:oaks_legacy/data/data_manager.dart';
import 'package:oaks_legacy/data/database_manager.dart';
import 'package:oaks_legacy/item/item_list_screen.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/models/preferences.dart';
import 'package:oaks_legacy/models/tracker.dart';
import 'package:oaks_legacy/models/flag.dart';
import 'package:oaks_legacy/data/file_manager.dart';
import 'package:oaks_legacy/models/pokemon.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:http/http.dart' as http;
import 'package:oaks_legacy/screens/forgotpassword_screen.dart';
import 'package:oaks_legacy/screens/maintainance_screen.dart';
import 'package:oaks_legacy/screens/start_screen.dart';
import 'package:oaks_legacy/screens/your_trackers.dart';
import 'package:oaks_legacy/tracker/tracker_details_screen.dart';
import 'package:oaks_legacy/tracker/tracker_list_screen.dart';
import 'package:oaks_legacy/utils/trackers_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BaseBackground(),
          Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                fontSize: 30,
                color: cWarningTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initData() async {
    //Starts Shared Preferences and Supabase
    await DataManager.start();

    final session = Supabase.instance.client.auth.currentSession;
    final user = Supabase.instance.client.auth.currentUser;

    if (session != null && user != null) {
      logUser(user.id);
    }

    DataManager.setUserPreferences();
    await DataManager.setSystemFlags();

    if (kFlags.underMaintenance == true) {
      openNextScreen(const MaintainanceScreen());
    } else {
      //********* Resolve Pokedex file *********\\
      String pokedex = await fetchData(kServerPokedexLocation);
      kPokedex = await Pokemon.createPokedex(pokedex);

      //***************************************\\

      if (html.window.location.href.contains('code=') &&
          !html.window.location.href.contains('signup=complete')) {
        String? code =
            Uri.parse(html.window.location.href).queryParameters['code'];
        //https://oaks-legacy.vercel.app/?error=access_denied&error_code=403&error_description=Email+link+is+invalid+or+has+expired
        // try {
        // await Supabase.instance.client.auth.exchangeCodeForSession(code!);
        // } catch (err) {}

        // var access = Supabase.instance.client.auth.currentSession!.accessToken;
        // openNextScreen(ForgotPasswordScreen(resetCode: access));
        openNextScreen(ForgotPasswordScreen(resetCode: code));
      } else {
        openNextScreen(const StartScreen());
      }
    }
  }

  Future<String> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decode the response body explicitly with the correct encoding
      String responseBody = utf8.decode(response.bodyBytes);
      return responseBody;
    } else {
      throw Exception('Failed to load server version');
    }
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



//************REMEMBERS
//For debugging local dex:
// var file = await rootBundle.loadString(kPokedexFileLocation);
// kPokedex = await Pokemon.createPokedex(file);

// For lazy load the Loading Screen
// await Future.delayed(const Duration(seconds: 2));

//Previous way to handle versioning.
// FileManager.removeAllKeys();
// Data serverData =
//     Data.fromJson(jsonDecode(await fetchData(kServerVersionLocation)));

// bool checkVersioning = true;

//********* Resolve Versions file *********\\
// Data localData = (FileManager.exists(kVersionsKey))
//     ? Data.fromJson(jsonDecode(FileManager.get(kVersionsKey)))
//     : serverData;

// FileManager.save(kVersionsKey, jsonEncode(localData));
//***************************************\\


//OPEN TRACKER AS FIRST SCREEN WITH DATA
// //******** Open Tracker Details FIRST ********
// var trackers = await getAllTrackers();
// if (trackers.isEmpty)
// // To create a tracker quickly
// {
//   String gameName = "Pokemon Sword";
//   String dexName = "Regional";
//   String trackerType = "Shiny Living Dex";
//   String trackerName =
//       '${gameName.replaceAll('Pokemon', '').replaceAll(' ', '')}-${dexName.replaceAll(' ', '')}-${trackerType.replaceAll(' ', '')}';
//   Tracker tracker = createTracker(
//       trackerName, gameName, dexName, trackerType,
//       save: true);
// }
// trackers = await getAllTrackers();
// //006 Chansey (Female Only)
// //036 Gallade (Male Only)
// //210 Zarude (Genderless)
// openNextScreen(TrackerDetailsPage(
//   pokemons: trackers.first.pokemons,
//   indexes: [5],
//   onStateChange: () {
//     saveTracker(trackers.first);
//   },
// ));
// //******** Open Tracker Details FIRST ********

      // openNextScreen(CollectionScreen());

//openNextScreen(const YourTrackersScreen());
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