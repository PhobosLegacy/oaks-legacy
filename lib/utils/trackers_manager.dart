import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:oaks_legacy/file_manager.dart';
import '../constants.dart';
import '../models/tracker.dart';
import '../models/enums.dart';
import '../models/game.dart';
import '../models/item.dart';
import '../models/pokemon.dart';

Future<List<Tracker>> getAllTrackers() async {
  List<Tracker> localTrackers = [];

  var keys = FileManager.getAllByPrefix(kTrackerPrefix);
  for (var key in keys) {
    Tracker tracker = Tracker.fromJson(jsonDecode(FileManager.get(key)));
    localTrackers.add(tracker);
  }

  return localTrackers;
}

getTracker(String ref) => Tracker.fromJson(jsonDecode(FileManager.get(ref)));

saveTracker(Tracker tracker) =>
    FileManager.save(tracker.ref, jsonEncode(tracker));

deleteTracker(String name) => FileManager.delete(name);

Tracker createTracker(
    String trackerName, String gameName, String dexName, String trackerType) {
  List<Item> pokemons = [];
  bool isShinyTracker = trackerType.contains("Shiny");
  bool isLivingDexTracker = trackerType.contains("Living");

  Tracker tracker =
      Tracker.create(trackerName, gameName, dexName, trackerType, pokemons);

  List<Pokemon> pokedex = List.from(kPokedex);
  for (var pokemon in pokedex) {
    Item? item = checkPokemon(pokemon,
        gameName: gameName,
        dexName: dexName,
        entryOrigin: tracker.ref,
        isShinyTracker: isShinyTracker,
        isLivingDexTracker: isLivingDexTracker);
    if (item != null) {
      if (isLivingDexTracker) {
        if (item.hasGenderDiff()) {
          String variant =
              (trackerType.contains("Shiny")) ? "-shiny-" : "-normal-";

          Item female = Item.copy(item);
          female.gender = PokemonGender.female;
          female.displayName = "${female.name} ♀";

          female.displayImage = item.image.firstWhere(
              (img) => img.contains("-f.") && img.contains(variant));

          Item male = Item.copy(item);
          male.gender = PokemonGender.male;
          male.displayName = "${male.name} ♂";
          male.displayImage = item.image.firstWhere(
              (img) => img.contains("-m.") && img.contains(variant));

          item.forms.insert(0, male);
          item.forms.insert(1, female);
        }
      }
      //(dexPokemon.formName == "") ? dexPokemon.name : dexPokemon.formName,
      item.displayName = item.name;
      pokemons.add(item);
    }
  }
  tracker.pokemons.sortBy((pokemon) => pokemon.number);
  tracker = applyTrackerChanges(tracker);

  saveTracker(tracker);

  return tracker;
}

//Some tracker requires specific changes or additions to the Pokemon
Tracker applyTrackerChanges(Tracker tracker) {
  if (tracker.dex == "Vivillons") {
    tracker.pokemons.addAll(tracker.pokemons.first.forms);
    tracker.pokemons.removeAt(0);
  }
  return tracker;
}

Item? checkPokemon(
  Pokemon pokemon, {
  required String gameName,
  required String dexName,
  required String entryOrigin,
  required bool isShinyTracker,
  required bool isLivingDexTracker,
}) {
  Item? item;

  if (pokemon.forms.isEmpty && pokemon.hasGameAndDex(gameName, dexName)) {
    Game game = pokemon.getGameDex(gameName, dexName);
    if ((isShinyTracker && game.shinyLocked == "UNLOCKED") || !isShinyTracker) {
      item = createNewItem(pokemon, game, entryOrigin, isShinyTracker);
    }
  } else if (pokemon.forms.isNotEmpty) {
    List<Item> forms = [];
    for (var form in pokemon.forms) {
      Item? itemFromForm = checkPokemon(form,
          gameName: gameName,
          dexName: dexName,
          entryOrigin: entryOrigin,
          isShinyTracker: isShinyTracker,
          isLivingDexTracker: isLivingDexTracker);

      if (itemFromForm != null) {
        forms.add(itemFromForm);
      }
    }
    if (pokemon.hasGameAndDex(gameName, dexName)) {
      Game game = pokemon.getGameDex(gameName, dexName);
      if ((isShinyTracker && game.shinyLocked == "UNLOCKED") ||
          !isShinyTracker) {
        item = createNewItem(pokemon, game, entryOrigin, isShinyTracker);
        item.forms.addAll(forms);
        if (item.forms.length == 1) {
          item.forms.clear();
        }
      }
    } else if (forms.isNotEmpty) {
      item = forms[0];
      forms.removeAt(0);
      item.forms.addAll(forms);
    }

    if (!isLivingDexTracker && item != null) {
      item.forms.clear();
    }
  }

  return item;
}

Item createNewItem(Pokemon pokemon, Game game, entryOrigin, isShinyTracker) {
  Item item = Item.fromDex(pokemon, game, entryOrigin, useGameDexNumber: true);
  item.forms.clear();
  item.displayName = (item.formName == "") ? item.name : item.formName;
  if (isShinyTracker) {
    item.displayImage = item.image.firstWhere((img) => img.contains("-shiny-"));
    item.attributes.add(PokemonAttributes.isShiny);
    // for (var form in item.forms) {
    //   form.displayImage =
    //       form.image.firstWhere((img) => img.contains("-shiny-"));
    //   form.attributes.add(PokemonAttributes.isShiny);
    // }
  }
  if (pokemon.genderRatio.genderless == "100") {
    item.gender = PokemonGender.genderless;
  } else if (pokemon.genderRatio.male == "100") {
    item.gender = PokemonGender.male;
  } else if (pokemon.genderRatio.female == "100") {
    item.gender = PokemonGender.female;
  }
  item.originalLocation = game.name;
  item.currentLocation = game.name;
  return item;
}
