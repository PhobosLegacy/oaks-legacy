import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/pokemon.dart';

import 'test_helper.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Pokemon.dart', () {
    test('Create Pokedex', () async {
      // Arrange
      var file = await rootBundle.loadString(kPokedexFileLocation);

      // Act
      List<Pokemon> kPokedex = await Pokemon.createPokedex(file);

      // Assert
      expect(kPokedex, isNotNull);
      expect(kPokedex, isNotEmpty);
      expect(kPokedex.length, equals(1024));
    });

    for (final pokemon in createPokemonPkmSample) {
      test('.fromJson .toJson - $pokemon', () async {
        // Arrange
        var file = await rootBundle.loadString(kPokedexFileLocation);
        List<Pokemon> kPokedex = await Pokemon.createPokedex(file);

        var pkmTestFile =
            await rootBundle.loadString("test/data/${pokemon['name']}.json");

        // Act
        Pokemon pkmFromDex =
            kPokedex.firstWhere((element) => element.number == pokemon['id']);

        Pokemon pkmFromTestFile = Pokemon.fromJson(jsonDecode(pkmTestFile));

        // Assert
        // debugPrint(jsonEncode(pkmFromDex));
        expect(jsonEncode(pkmFromDex), equals(jsonEncode(pkmFromTestFile)));
      });
    }

    for (final keepForm in keepForms) {
      test('Copy Pokemon Keep Form: $keepForm', () async {
        // Arrange
        var pkmFile = await rootBundle
            .loadString("test/data/create_pokedex_venusaur.json");

        Pokemon pkm = Pokemon.fromJson(jsonDecode(pkmFile));

        // Act
        Pokemon copiedPkm = Pokemon.copy(pkm, keepForm['value']);

        // Assert
        // debugPrint(jsonEncode(pkmFromDex));
        expect(copiedPkm.forms, (keepForm['value']) ? isNotEmpty : isEmpty);
      });
    }
  });
}
