import 'package:collection/collection.dart';
import 'package:oaks_legacy/data/data_manager.dart';
import '../constants.dart';
import '../models/tracker.dart';
import '../models/enums.dart';
import '../models/game.dart';
import '../models/item.dart';
import '../models/pokemon.dart';

Future<List<Tracker>> getAllTrackers() async {
  List<Tracker> localTrackers = List<Tracker>.empty(growable: true);

  // var keys = FileManager.getAllByPrefix(kTrackerPrefix);
  // for (var key in keys) {
  //   Tracker tracker = Tracker.fromDatabase(jsonDecode(FileManager.get(key)));
  //   localTrackers.add(tracker);
  // }
  localTrackers.addAll(await DataManager.getTrackers());
  return localTrackers;
}

Future<Tracker> getTracker(String ref) async {
  return await DataManager.getTracker(ref);
  // Tracker.fromJson(jsonDecode(FileManager.get(ref)));
}

saveTracker(Tracker tracker) async {
  await DataManager.saveTracker(tracker);
  // FileManager.save(tracker.ref, jsonEncode(tracker));
}

Future deleteTracker(String name) async {
  await DataManager.removeTracker(name);
  // FileManager.delete(name);
}

Future<Tracker> createTracker(
    String trackerName, String gameName, String dexName, String trackerType,
    {bool save = true}) async {
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
        isShinyTracker: isShinyTracker);
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
      tracker.pokemons.add(item);
    }
  }

  tracker = applyTrackerChanges(tracker, isLivingDexTracker);
  tracker.pokemons.sortBy((pokemon) =>
      (tracker.pokemons.any((element) => element.number == ""))
          ? pokemon.natDexNumber
          : pokemon.number);
  // tracker.pokemons.sortBy((pokemon) => pokemon.number);

  if (save) await saveTracker(tracker);

  return tracker;
}

//Some tracker requires specific changes or additions to the Pokemon
Tracker applyTrackerChanges(Tracker tracker, bool isLivingDexTracker) {
  if (["Gigantamax Forms"].contains(tracker.dex)) {
    List<Item> flatList = [];
    for (var pokemon in tracker.pokemons) {
      flatList.addAll(flatIt(pokemon, includeParent: true));
    }
    for (var element in flatList) {
      element.displayName = element.name.replaceAll("Gigantamax", "G. ");
    }
    tracker.pokemons = flatList;
  }

  if (["Vivillons", "Mightiest Mark"].contains(tracker.dex)) {
    List<Item> flatList = [];
    for (var pokemon in tracker.pokemons) {
      flatList.addAll(flatIt(pokemon));
    }
    tracker.pokemons = flatList;
  }

  if (!isLivingDexTracker) {
    for (var pokemon in tracker.pokemons) {
      pokemon.forms.clear();
    }
  }

  return tracker;
}

List<Item> flatIt(Item pokemon, {bool includeParent = false}) {
  List<Item> flat = [];
  if (pokemon.forms.isEmpty) return [pokemon];
  for (var form in pokemon.forms) {
    if (form.forms.isEmpty) {
      if (includeParent) flat.add(pokemon);
      flat.add(form);
    } else {
      flat.addAll(flatIt(form));
    }
  }
  return flat;
}

Item? checkPokemon(Pokemon pokemon,
    {required String gameName,
    required String dexName,
    required String entryOrigin,
    required bool isShinyTracker}) {
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
          isShinyTracker: isShinyTracker);

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

        if (item.hasGenderDiff() || item.forms.length == 1) {
          item.forms.removeAt(0);
        }
      }
    } else if (forms.isNotEmpty) {
      item = forms[0];
      forms.removeAt(0);
      item.forms.addAll(forms);
    }
  }

  //To avoid a exclusive pokemon with form to be the main parent
  if (item != null && item.forms.isNotEmpty) {
    //if notes is not empty means it is an exclusive form
    if (item.game.notes != "" &&
        item.forms.any((element) => element.game.notes == "")) {
      Item parent =
          item.forms.firstWhere((element) => element.game.notes == "");
      parent.forms.clear();
      for (var form in item.forms) {
        if (form.ref == parent.ref) {
          parent.forms.insert(0, Item.copy(form));
        } else {
          parent.forms.add(Item.copy(form));
        }
      }
      return parent;
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
  }
  item.originalLocation = game.name;
  item.currentLocation = game.name;
  return item;
}
