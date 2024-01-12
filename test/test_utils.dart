import 'package:flutter_test/flutter_test.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/models/pokemon.dart';

// Validate an Item based on scenarios from itemPokemonPkmSample.
// Drills down on forms tovalidate them as well
validateItemFromPokemon(
  Item item,
  Pokemon pkm,
  Game game,
  String origin,
  scenario,
) {
  // Final Properties
  expect(item.name, equals(pkm.name));
  expect(item.formName, equals(pkm.formName));
  expect(item.number,
      equals((scenario['useGameNumber']) ? game.number : pkm.number));
  expect(item.natDexNumber, equals(pkm.number));
  expect(item.ref.startsWith(pkm.ref), isTrue);
  expect(item.type1, equals(pkm.type1));
  expect(item.type2, equals(pkm.type2));
  expect(item.forms.length, equals(pkm.forms.length));

  expect(item.image, equals(pkm.image));
  expect(item.game.toJson(), equals(game.toJson()));
  expect(item.origin, equals(origin));

  // Default Properties
  expect(item.displayName, equals(pkm.name));
  expect(item.displayImage, equals(pkm.image[0]));
  expect(item.gender, equals(scenario['gender']));
  expect(item.ability, equals(kValueNotFound));
  expect(item.ball, equals(PokeballType.undefined));
  expect(item.level, equals(kValueNotFound));
  expect(item.captured, isFalse);
  expect(item.catchDate, isEmpty);
  expect(item.originalLocation, equals(game.name));
  expect(item.currentLocation, equals(origin));
  expect(item.trainerName, isEmpty);
  expect(item.capturedMethod, equals(CaptureMethod.unknown));
  expect(item.attributes, equals(isEmpty));

  // Drill down on forms
  if (pkm.forms.isNotEmpty) {
    for (var i = 0; i < pkm.forms.length; i++) {
      validateItemFromPokemon(
          item.forms[i], pkm.forms[i], game, origin, scenario);
    }
  }
}

validateItemFromJson(Item item, toCompare) {
  // Final Properties
  expect(item.name, equals(toCompare['name']));
  expect(item.formName, equals(toCompare['formName']));
  expect(item.number, equals(toCompare['number']));
  expect(item.natDexNumber, equals(toCompare['natDexNumber']));
  expect(item.ref, equals(toCompare['ref']));
  expect(item.type1.name, equals(toCompare['type1']));
  expect(item.type2!.name, equals(toCompare['type2']));
  expect(item.forms.length, equals(toCompare['forms'].length));
  expect(item.image, equals(toCompare['image']));
  expect(item.game.toJson(), equals(toCompare['game']));
  expect(item.origin, equals(toCompare['origin']));

  // Default Properties
  expect(item.displayName, equals(toCompare['displayName']));
  expect(item.displayImage, equals(toCompare['displayImage']));
  expect(item.gender.name, equals(toCompare['gender']));
  expect(item.ability, equals(toCompare['ability']));
  expect(item.ball.name, equals(toCompare['ball']));
  expect(item.level, equals(toCompare['level']));
  expect(item.captured, toCompare['captured']);
  expect(item.catchDate, toCompare['catchDate']);
  expect(item.originalLocation, equals(toCompare['originalLocation']));
  expect(item.currentLocation, equals(toCompare['currentLocation']));
  expect(item.trainerName, toCompare['trainerName']);
  expect(item.capturedMethod.name, equals(toCompare['capturedMethod']));
  expect(item.attributes, equals(toCompare['attributes']));

  // Drill down on forms
  if (item.forms.isNotEmpty) {
    for (var i = 0; i < item.forms.length; i++) {
      validateItemFromJson(item.forms[i], toCompare['forms'][i]);
    }
  }
}
