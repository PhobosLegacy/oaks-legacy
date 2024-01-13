// import 'package:flutter/foundation.dart'; //for debugPrint(jsonEncode(pkmFromDex));
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/pokemon.dart';
import 'package:oaks_legacy/models/tracker.dart';
import 'package:oaks_legacy/utils/trackers_manager.dart';

import 'test_scenarios.dart';
import 'test_utils.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    var file = await File(kPokedexFileLocation).readAsString();
    kPokedex = await Pokemon.createPokedex(file);
  });

  group('Tracker_Manager.dart', () {
    for (final trackerData in trackers) {
      test('Create Tracker -> ${trackerData['testFileName']}', () async {
        // Arrange
        var file = jsonDecode(
            await File('test/tracker_data/${trackerData['testFileName']}.json')
                .readAsString());

        // Act
        Tracker tracker = createTracker(
            trackerData['trackerName'],
            trackerData['gameName'],
            trackerData['dexName'],
            trackerData['trackerType'],
            save: false);

        // Assert
        expect(tracker, isNotNull, reason: "Tracker is null.");
        expect(tracker.pokemons.length, equals(trackerData['lenght']),
            reason: "Size of pokemons in tracker doesn't match test files.");

        for (var i = 0; i < tracker.pokemons.length; i++) {
          validateItemFromTracker(
              tracker.pokemons[i], file['pokemons'][i], tracker.ref, i);
        }
      });
    }

    // for (final trackerData in createTrackers) {
    //   test('Create Tracker JSON - TEMP', () async {
    //     // Act

    //     String gameName = trackerData['gameName'];
    //     String dexName = trackerData['dexName'];
    //     String trackerType = trackerData['trackerType'];
    //     String trackerName =
    //         '${gameName.replaceAll('Pokemon', '').replaceAll(' ', '')}-${dexName.replaceAll(' ', '')}-${trackerType.replaceAll(' ', '')}';

    //     // String gameName = 'Pokemon Legends: Arceus';
    //     // String dexName = 'Regional';
    //     // String trackerType = 'Shiny Living Dex';
    //     // String trackerName =
    //     //     '${gameName.replaceAll('Pokemon ', '')}-$dexName-$trackerType';

    //     Tracker tracker = createTracker(
    //         trackerName, gameName, dexName, trackerType,
    //         save: false);

    //     String formattedJsonString =
    //         const JsonEncoder.withIndent('  ').convert(tracker);

    //     RegExp specialChars = RegExp(r'[^\w\s]');
    //     var fileName = trackerName.replaceAll(specialChars, '');

    //     String filePath = 'test/tracker_data/$fileName.json';
    //     File(filePath).writeAsStringSync(formattedJsonString);

    //     // debugPrint('--------- STARTS HERE ---------');
    //     // debugPrint(jsonEncode(tracker));
    //     // debugPrint(jsonEncode(tracker.pokemons.length));
    //     debugPrint(jsonEncode({
    //       'testFileName': fileName,
    //       'trackerName': trackerName,
    //       'gameName': gameName,
    //       'dexName': dexName,
    //       'trackerType': trackerType,
    //       'lenght': tracker.pokemons.length
    //     }));
    //     // debugPrint('--------- ENDING HERE ---------');
    //   });
    // }
  });
}

// GOOD NOTES:
        // tracker.ref = "";
        // file["ref"] = "";
        // To validate both as THEY ARE (but ref values make it tricky)
        // var icaro = jsonEncode(tracker);
        // var other = jsonEncode(file);
        // expect(icaro, equals(other));

        // debugPrint('--------- STARTS HERE ---------');
        // debugPrint(jsonEncode(tracker));
        // debugPrint(jsonEncode(tracker.pokemons.length));
        // debugPrint('--------- ENDING HERE ---------');

        // debugPrint("ATT DATA");
        // debugPrint(item.attributes.length.toString());
        // item.attributes.forEach((attr) => debugPrint(attr.name));
        // debugPrint(toCompare['attributes'].length.toString());
        // toCompare['attributes'].forEach((attr) => debugPrint(attr));
        // debugPrint("ATT DATA END ");