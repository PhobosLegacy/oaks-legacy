import 'dart:convert';
import 'dart:io';
// import 'package:flutter/foundation.dart'; for debugPrint(jsonEncode(pkmFromDex));
import 'package:flutter_test/flutter_test.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/pokemon.dart';
import 'test_scenarios.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Pokemon.dart', () {
    test('Create Pokedex', () async {
      // Arrange
      var file = await File(kPokedexFileLocation).readAsString();

      // Act
      List<Pokemon> kPokedex = await Pokemon.createPokedex(file);

      // Assert
      expect(kPokedex, isNotNull);
      expect(kPokedex, isNotEmpty);
      expect(kPokedex.length, equals(1024));
    });

    for (final pokemon in createPokemonPkmSample) {
      test('Create Pokemon - .fromJson .toJson - $pokemon', () async {
        // Arrange
        var file = await File(kPokedexFileLocation).readAsString();
        List<Pokemon> kPokedex = await Pokemon.createPokedex(file);

        var pkmTestFile =
            await File("test/data/${pokemon['name']}.json").readAsString();

        // Act
        Pokemon pkmFromDex =
            kPokedex.firstWhere((element) => element.number == pokemon['id']);

        Pokemon pkmFromTestFile = Pokemon.fromJson(jsonDecode(pkmTestFile));

        // Assert
        expect(jsonEncode(pkmFromDex), equals(jsonEncode(pkmFromTestFile)));
      });
    }

    for (final keepForm in keepForms) {
      test('Copy Pokemon - Keep Form: $keepForm', () async {
        // Arrange
        var pkmFile =
            await File("test/data/create_pokedex_venusaur.json").readAsString();

        Pokemon pkm = Pokemon.fromJson(jsonDecode(pkmFile));

        // Act
        Pokemon copiedPkm = Pokemon.copy(pkm, keepForm['value']);

        // Assert
        expect(copiedPkm.forms, (keepForm['value']) ? isNotEmpty : isEmpty);
      });
    }
  });
}
