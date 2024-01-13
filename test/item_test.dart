import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/models/pokemon.dart';
import 'test_scenarios.dart';
import 'test_utils.dart';
// import 'package:flutter/foundation.dart'; //for debugPrint(jsonEncode(pkmFromDex));

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Item.dart', () {
    for (final scenario in itemPokemonPkmSample) {
      test('Create Item .fromDex ${scenario['id']}', () async {
        // Arrange
        var file = await File(kPokedexFileLocation).readAsString();
        List<Pokemon> kPokedex = await Pokemon.createPokedex(file);

        Pokemon pkm =
            kPokedex.firstWhere((element) => element.number == scenario['id']);

        Game game = Game(
            name: "Pokemon Sword",
            dex: "New Dex",
            number: "999",
            notes: "",
            shinyLocked: "UNLOCKED");

        String origin = "origin";

        // Act
        Item item = Item.fromDex(pkm, game, origin,
            useGameDexNumber: scenario['useGameNumber']);

        // Assert
        expect(item, isNotNull);
        validateItemFromPokemon(item, pkm, game, origin, scenario);
      });
    }

    for (final scenario in itemPkmSample) {
      test('Create Item .fromJson}', () async {
        // Arrange
        var file =
            await File("test/data/${scenario['name']}.json").readAsString();
        var toCompare = jsonDecode(file);

        // Act
        Item item = Item.fromJson(toCompare);

        // Assert
        expect(item, isNotNull);
        validateItemFromJson(item, toCompare);
      });
    }

    for (final scenario in itemPkmSample) {
      test('Create Item .toJson}', () async {
        // Arrange
        var file =
            await File("test/data/${scenario['name']}.json").readAsString();

        // Act
        Item item = Item.fromJson(jsonDecode(file));

        // Assert
        expect(jsonEncode(item), equals(jsonEncode(jsonDecode(file))));
      });
    }

    for (final scenario in itemPkmSample) {
      test('Copy Item', () async {
        // Arrange
        var file =
            await File("test/data/${scenario['name']}.json").readAsString();

        Item toCompare = Item.fromJson(jsonDecode(file));
        toCompare.forms.clear();

        // Act
        Item item = Item.copy(toCompare);

        // Assert
        expect(item.toJson(), toCompare.toJson());
      });
    }
  });
}
