import 'item.dart';
import '../constants.dart';
import 'package:uuid/uuid.dart';
import 'package:oaks_legacy/models/enums.dart';

class Tracker {
  String name;
  String ref;
  String game;
  String dex;
  String type;
  List<Item> pokemons;

  Tracker.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        ref = json['ref'],
        game = json['game'],
        dex = json['dex'],
        type = json['type'],
        pokemons = json['pokemons'] != null
            ? List<Item>.from(
                json['pokemons'].map((model) => Item.fromJson(model)))
            : [];

  Tracker.create(String trackerName, String gameName, String dexName,
      String trackerType, List<Item> pokemonList)
      : name = trackerName,
        ref = kTrackerPrefix + const Uuid().v4().toString(),
        game = gameName,
        dex = dexName,
        type = trackerType,
        pokemons = pokemonList;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ref': ref,
      'game': game,
      'dex': dex,
      'type': type,
      'pokemons': pokemons.map((i) => i.toJson()).toList(),
    };
  }

  total() {
    var count = pokemons.where((element) => element.forms.isEmpty).length;

    pokemons
        .where((element) => element.forms.isNotEmpty)
        .toList()
        .forEach((element) {
      count += element.forms.length;
    });

    return count;
  }

  capturedTotal() {
    var count = pokemons
        .where((element) => element.forms.isEmpty && element.captured == true)
        .length;

    pokemons
        .where((element) => element.forms.isNotEmpty)
        .toList()
        .forEach((pokemon) {
      count += pokemon.forms.where((form) => form.captured == true).length;
    });

    return count;
  }

  missingTotal() {
    var count = pokemons
        .where((element) => element.forms.isEmpty && element.captured == false)
        .length;

    pokemons
        .where((element) => element.forms.isNotEmpty)
        .toList()
        .forEach((pokemon) {
      count += pokemon.forms.where((form) => form.captured == false).length;
    });

    return count;
  }

  percentage() {
    // var total = pokemons.where((element) => element.forms.isEmpty).length;

    // pokemons
    //     .where((element) => element.forms.isNotEmpty)
    //     .toList()
    //     .forEach((element) {
    //   total += element.forms.length;
    // });

    // var captured = pokemons
    //     .where((element) => element.forms.isEmpty && element.captured == true)
    //     .length;

    // pokemons
    //     .where((element) => element.forms.isNotEmpty)
    //     .toList()
    //     .forEach((pokemon) {
    //   captured += pokemon.forms.where((form) => form.captured == true).length;
    // });

    var perc = (capturedTotal() / total()) * 100;

    return perc.toStringAsFixed(2);
  }

  applyAllFilters(
      List<FilterType> filters, String? words, List<String>? types) {
    List<Item> temp = [];
    temp.addAll(pokemons.toList());

    for (var filter in filters) {
      switch (filter) {
        case FilterType.captured:
          temp = temp
              .where((element) =>
                  isPokemonCaptured(element) == CaptureType.full ||
                  isPokemonCaptured(element) == CaptureType.partial)
              .toList();
          break;
        case FilterType.notCaptured:
          temp = temp
              .where((element) =>
                  isPokemonCaptured(element) == CaptureType.empty ||
                  isPokemonCaptured(element) == CaptureType.partial)
              .toList();
          break;
        case FilterType.exclusiveOnly:
          temp = temp.where((element) => element.game.notes != "").toList();
          break;
        case FilterType.byValue:
          temp = temp
              .where((element) =>
                  element.name.toLowerCase().contains(words!.toLowerCase()))
              .toList();
          break;
        case FilterType.byType:
          if (types != null && types.isNotEmpty) {
            temp = temp
                .where((element) =>
                    containsType(types, element.type1) ||
                    containsType(types, element.type2))
                .toList();
          }
          break;
        case FilterType.numAsc:
          temp.sort((a, b) => a.number.compareTo(b.number));
          break;
        case FilterType.numDesc:
          temp.sort((a, b) => b.number.compareTo(a.number));
          break;
        case FilterType.nameAsc:
          temp.sort((a, b) => a.name.compareTo(b.name));
          break;
        case FilterType.nameDesc:
          temp.sort((a, b) => b.name.compareTo(a.name));
          break;
        default:
          return pokemons;
      }
    }

    return temp;
  }

  containsType(List<String>? values, PokemonType? type) {
    if (type == null) return false;
    return values!.contains(type.name);
  }

  static CaptureType isPokemonCaptured(Item pokemon) {
    if (pokemon.forms.isNotEmpty) {
      if (pokemon.forms.every((element) => element.captured == true)) {
        return CaptureType.full;
      }

      if (pokemon.forms.every((element) => element.captured == false)) {
        return CaptureType.empty;
      }

      return CaptureType.partial;
    } else {
      return (pokemon.captured) ? CaptureType.full : CaptureType.empty;
    }
  }

  static bool keepTabOpen(Item pokemon) {
    switch (isPokemonCaptured(pokemon)) {
      case CaptureType.full:
      case CaptureType.partial:
        return true;
      case CaptureType.empty:
        return false;
      default:
        return false;
    }
  }
}
