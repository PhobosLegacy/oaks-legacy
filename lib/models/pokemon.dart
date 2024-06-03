import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';
import 'breeding.dart';
import 'gender_ratio.dart';
import 'weakness.dart';
import 'game.dart';
import 'enums.dart';

class Pokemon {
  final String name;
  final String formName;
  final String species;
  final String height;
  final String weight;
  final List<dynamic> image;
  final String number;
  final String ref;
  final PokemonType type1;
  final PokemonType? type2;
  final List<Pokemon> forms;
  final List<Game> games;
  final Weakness weakness;
  final List<dynamic> abilities;
  final String? hiddenAbility;
  final Breeding breeding;
  final GenderRatio genderRatio;
  final String generation;

  int currentImageIndex = 0;

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        formName = json['formName'],
        species = json['species'],
        height = json['height'],
        weight = json['weight'],
        image = json['image'],
        number = json['number'],
        ref = json['ref'],
        type1 = PokemonType.values.byName(json['type1']),
        type2 = json['type2'] == null
            ? null
            : PokemonType.values.byName(json['type2']),
        forms = json['forms'] != null
            ? List<Pokemon>.from(
                json['forms'].map((model) => Pokemon.fromJson(model)))
            : [],
        games = json['games'] != null
            ? List<Game>.from(
                json['games'].map((model) => Game.fromJson(model)))
            : [],
        weakness = Weakness(
          quarter: json['weaknessquarter'] ?? [],
          half: json['weaknesshalf'] ?? [],
          none: json['weaknessnone'] ?? [],
          double: json['weaknessdouble'] ?? [],
          quadruple: json['weaknessquadruple'] ?? [],
        ),
        abilities = json['abilities'],
        hiddenAbility = json['hiddenAbility'],
        breeding = Breeding.fromJson(json['breeding']),
        genderRatio = GenderRatio.fromJson(json['genderRatio']),
        generation = json['generation'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'formName': formName,
      'species': species,
      'height': height,
      'weight': weight,
      'image': image,
      'number': number,
      'ref': ref,
      'type1': type1.name,
      'type2': type2?.name,
      'forms': forms.map((i) => i.toJson()).toList(),
      'games': games.map((i) => i.toJson()).toList(),
      'weaknessquarter': weakness.quarter,
      'weaknesshalf': weakness.half,
      'weaknessnone': weakness.none,
      'weaknessdouble': weakness.double,
      'weaknessquadruple': weakness.quadruple,
      'abilities': abilities,
      'hiddenAbility': hiddenAbility,
      'breeding': breeding.toJson(),
      'genderRatio': genderRatio.toJson(),
      'generation': generation
    };
  }

  Pokemon.copy(Pokemon pokemon, bool keepForms)
      : name = pokemon.name,
        formName = pokemon.formName,
        species = pokemon.species,
        height = pokemon.height,
        weight = pokemon.weight,
        image = pokemon.image,
        number = pokemon.number,
        ref = pokemon.ref,
        type1 = pokemon.type1,
        type2 = pokemon.type2,
        forms = (keepForms) ? pokemon.forms : [],
        games = pokemon.games,
        weakness = pokemon.weakness,
        abilities = pokemon.abilities,
        hiddenAbility = pokemon.hiddenAbility,
        breeding = pokemon.breeding,
        genderRatio = pokemon.genderRatio,
        generation = pokemon.generation;

  static createPokedex(String file) async {
    Iterable l = jsonDecode(file);
    List<Pokemon> pokemons =
        List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));
    for (var pokemon in pokemons) {
      {
        if (pokemon.forms.isNotEmpty) {
          for (var form in pokemon.forms) {
            if (form.forms.isNotEmpty) {
              form.forms.insert(0, Pokemon.copy(form, false));
            }
          }
          //Pokemon with forms on their form don't need to be added
          if (pokemon.name != "Alcremie" && pokemon.name != "Urshifu") {
            pokemon.forms.insert(0, Pokemon.copy(pokemon, false));
          }
        }
      }
    }
    return pokemons;
  }

  formattedTypes() {
    var union = type1.name;
    if (type2 != null) {
      String? uni = type2?.name;
      union = '$union/$uni';
    }
    return union;
  }

  resetImage() {
    currentImageIndex = 0;
  }

  findImageIndexByVariant(PokemonVariant desiredVariant) {
    String genderCode = "-mf.";
    switch (imageGender()) {
      case PokemonGender.male:
        genderCode = "-m.";
        break;
      case PokemonGender.female:
        genderCode = "-f.";
        break;
      case PokemonGender.genderless:
        genderCode = "-g.";
        break;
      case PokemonGender.undefinied:
        genderCode = "-mf.";
        break;
    }

    String variant =
        (desiredVariant == PokemonVariant.shiny) ? "-shiny-" : "-normal-";

    currentImageIndex = image.indexWhere(
        (element) => element.contains(genderCode) && element.contains(variant));

    return currentImageIndex;
  }

  findImageIndexByGender(PokemonGender desiredGender) {
    String variant = (image[currentImageIndex].contains('-normal-'))
        ? "-normal-"
        : "-shiny-";

    String genderCode;
    switch (desiredGender) {
      case PokemonGender.female:
        genderCode = "-f.";
        break;
      case PokemonGender.male:
        genderCode = "-m.";
        break;
      case PokemonGender.genderless:
        genderCode = "-g.";
        break;
      default:
        genderCode = "-mf.";
        break;
    }

    currentImageIndex = image.indexWhere(
        (element) => element.contains(genderCode) && element.contains(variant));

    return currentImageIndex;
  }

  imageGender() {
    if (image[currentImageIndex].contains('-m.')) return PokemonGender.male;

    if (image[currentImageIndex].contains('-f.')) return PokemonGender.female;

    if (image[currentImageIndex].contains('-g.')) {
      return PokemonGender.genderless;
    }

    return PokemonGender.undefinied;
  }

  imageVariant() {
    if (image[currentImageIndex].contains('-normal-')) {
      return PokemonVariant.normal;
    }

    return PokemonVariant.shiny;
  }

  imageHasGenderAlter() {
    return !(image.any((element) => element.contains('-mf')) ||
        image.any((element) => element.contains('-g')));
  }

  static Image typeImage(PokemonType? type, {double? size}) {
    // String path = "images/types";
    String typeUrl = kImageLocalPrefix;

    switch (type) {
      case PokemonType.bug:
        typeUrl += 'types/bug.png';
        break;
      case PokemonType.dark:
        typeUrl += 'types/dark.png';
        break;
      case PokemonType.dragon:
        typeUrl += 'types/dragon.png';
        break;
      case PokemonType.electric:
        typeUrl += 'types/electric.png';
        break;
      case PokemonType.fire:
        typeUrl += 'types/fire.png';
        break;
      case PokemonType.grass:
        typeUrl += 'types/grass.png';
        break;
      case PokemonType.fairy:
        typeUrl += 'types/fairy.png';
        break;
      case PokemonType.fighting:
        typeUrl += 'types/fighting.png';
        break;
      case PokemonType.flying:
        typeUrl += 'types/flying.png';
        break;
      case PokemonType.ghost:
        typeUrl += 'types/ghost.png';
        break;
      case PokemonType.ground:
        typeUrl += 'types/ground.png';
        break;
      case PokemonType.ice:
        typeUrl += 'types/ice.png';
        break;
      case PokemonType.normal:
        typeUrl += 'types/normal.png';
        break;
      case PokemonType.poison:
        typeUrl += 'types/poison.png';
        break;
      case PokemonType.psychic:
        typeUrl += 'types/psychic.png';
        break;
      case PokemonType.rock:
        typeUrl += 'types/rock.png';
        break;
      case PokemonType.steel:
        typeUrl += 'types/steel.png';
        break;
      case PokemonType.water:
        typeUrl += 'types/water.png';
        break;
      default:
        throw ("Pokemon Type do not have a primary color defined");
    }

    return Image.network(
      typeUrl,
      width: (size == null) ? 23 : size,
    );
  }

  static Color typeColor(PokemonType type, bool isSecondaryColor) {
    switch (type) {
      case PokemonType.bug:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(132, 196, 4, 1)
            : const Color.fromRGBO(177, 218, 94, 1);
      case PokemonType.dark:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(92, 84, 100, 1)
            : const Color.fromRGBO(148, 142, 155, 1);
      case PokemonType.dragon:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(4, 115, 204, 1)
            : const Color.fromRGBO(87, 161, 221, 1);
      case PokemonType.electric:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 212, 4, 1)
            : const Color.fromRGBO(252, 227, 89, 1);
      case PokemonType.fire:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 156, 60, 1)
            : const Color.fromRGBO(252, 188, 133, 1);
      case PokemonType.grass:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(52, 196, 76, 1)
            : const Color.fromRGBO(127, 215, 139, 1);
      case PokemonType.fairy:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 159, 237, 1)
            : const Color.fromRGBO(252, 184, 244, 1);
      case PokemonType.fighting:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(228, 44, 108, 1)
            : const Color.fromRGBO(236, 116, 154, 1);
      case PokemonType.flying:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(140, 172, 228, 1)
            : const Color.fromRGBO(178, 200, 236, 1);
      case PokemonType.ghost:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(76, 108, 180, 1)
            : const Color.fromRGBO(137, 157, 205, 1);
      case PokemonType.ground:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(236, 116, 52, 1)
            : const Color.fromRGBO(236, 148, 100, 1);
      case PokemonType.ice:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(76, 212, 196, 1)
            : const Color.fromRGBO(147, 228, 220, 1);
      case PokemonType.normal:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(148, 156, 164, 1)
            : const Color.fromRGBO(182, 189, 194, 1);
      case PokemonType.poison:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(180, 100, 204, 1)
            : const Color.fromRGBO(206, 154, 223, 1);
      case PokemonType.psychic:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 100, 116, 1)
            : const Color.fromRGBO(252, 150, 161, 1);
      case PokemonType.rock:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(204, 180, 132, 1)
            : const Color.fromRGBO(219, 206, 173, 1);
      case PokemonType.steel:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(92, 140, 164, 1)
            : const Color.fromRGBO(154, 186, 198, 1);
      case PokemonType.water:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(52, 148, 220, 1)
            : const Color.fromRGBO(144, 196, 236, 1);
      default:
        throw ("Pokemon Type do not have a primary color defined");
    }
  }

  Game getGameDex(String gameName, String dexName) {
    return games.firstWhere(
        (element) => element.name == gameName && element.dex == dexName);
  }

  bool hasGameAndDex(String gameName, String gameDex) {
    return games.any((game) => game.name == gameName && game.dex == gameDex);
  }
}

extension Filter on List<Pokemon>? {
  findByName(String value) {
    if (int.tryParse(value) != null) return findByNumber(int.parse(value));
    List<Pokemon> filtered = [];

    for (var pokemon in this!) {
      if (pokemon.forms.isEmpty) {
        if (pokemon.name.toLowerCase().startsWith(value.toLowerCase())) {
          filtered.add(pokemon);
        }
      } else {
        List<Pokemon> pokemons = pokemon.forms.findByName(value);
        if (pokemons.isNotEmpty) {
          filtered.addAll(pokemons);
        }
      }
    }

    return filtered;
  }

  findByNumber(int value) {
    List<Pokemon> filtered = [];

    for (var pokemon in this!) {
      if (pokemon.forms.isEmpty) {
        if (int.parse(pokemon.number) == value) {
          filtered.add(pokemon);
        }
      } else {
        List<Pokemon> pokemons = pokemon.forms.findByNumber(value);
        if (pokemons.isNotEmpty) {
          filtered.addAll(pokemons);
        }
      }
    }

    return filtered;
  }

  findByType(List<String>? types) {
    List<Pokemon> filtered = [];

    for (var pokemon in this!) {
      if (pokemon.forms.isEmpty) {
        if (containsType(types!, [pokemon.type1, pokemon.type2])) {
          filtered.add(pokemon);
        }
      } else {
        List<Pokemon> pokemons = pokemon.forms.findByType(types);
        if (pokemons.isNotEmpty) {
          filtered.addAll(pokemons);
        }
      }
    }

    return filtered;
  }

  findByGeneration(List<String> generations) {
    List<Pokemon> filtered = [];

    for (var pokemon in this!) {
      if (pokemon.forms.isEmpty) {
        if (generations.contains(pokemon.generation)) {
          filtered.add(pokemon);
        }
      } else {
        List<Pokemon> pokemons = pokemon.forms.findByGeneration(generations);
        if (pokemons.isNotEmpty) {
          filtered.addAll(pokemons);
        }
      }
    }

    return filtered;
  }

  applyAllFilters(List<FilterType> filters, String? words, List<String>? types,
      List<String>? generations) {
    List<Pokemon> temp = [];
    temp.addAll(kPokedex);

    for (var filter in filters) {
      switch (filter) {
        case FilterType.byValue:
          temp = temp.findByName(words!);
          break;
        case FilterType.byType:
          if (types != null && types.isNotEmpty) {
            temp = temp.findByType(types);
          }
          break;
        case FilterType.generation:
          if (generations != null && generations.isNotEmpty) {
            temp = temp.findByGeneration(generations);
          }
          break;
        case FilterType.numAsc:
          temp.sort(
              (a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
          break;
        case FilterType.numDesc:
          temp.sort(
              (a, b) => int.parse(b.number).compareTo(int.parse(a.number)));
          break;
        case FilterType.nameAsc:
          temp.sort((a, b) => a.name.compareTo(b.name));
          break;
        case FilterType.nameDesc:
          temp.sort((a, b) => b.name.compareTo(a.name));
          break;
        default:
          return this;
      }
    }

    return temp;
  }

  checkParent(indexes) {
    Pokemon parent = current(indexes.take(indexes.length - 1).toList());

    if ((indexes.last + 1) == parent.forms.length) {
      indexes.removeLast();
      if (indexes.length == 1) return indexes;
      checkParent(indexes);
    }

    return indexes;
  }

  List<int> nextIndex(List<int> indexes) {
    if (indexes.length == 1) {
      indexes.last++;
    } else {
      indexes = checkParent(indexes);
      indexes.last++;
    }

    Pokemon nextPokemon = current(indexes);
    while (nextPokemon.forms.isNotEmpty) {
      indexes.add(0);
      nextPokemon = current(indexes);
    }
    return indexes;
  }

  removeLastIndex(indexes) {
    if ((indexes.last) == 0) {
      indexes.removeLast();
      removeLastIndex(indexes);
    }
    return indexes;
  }

  List<int> previousIndex(List<int> indexes) {
    if (indexes.length == 1) {
      indexes.last--;
    } else {
      indexes = removeLastIndex(indexes);
      indexes.last--;
    }

    Pokemon nextPokemon = current(indexes);
    while (nextPokemon.forms.isNotEmpty) {
      indexes.add(nextPokemon.forms.length - 1);
      nextPokemon = current(indexes);
    }
    return indexes;
  }

  Pokemon current(List<int> indexes) {
    Pokemon pokemon = this![indexes.first];
    for (var i = 1; i < indexes.length; i++) {
      pokemon = pokemon.forms[indexes[i]];
    }
    return pokemon;
  }

  bool isFirst(List<int> indexes) {
    Pokemon currentPokemon = current(indexes);
    Pokemon firstPokemon = this!.first;
    while (firstPokemon.forms.isNotEmpty) {
      firstPokemon = firstPokemon.forms.first;
    }
    if (firstPokemon == currentPokemon) return true;
    return false;
  }

  bool isLast(List<int> indexes) {
    Pokemon currentPokemon = current(indexes);
    Pokemon lastPokemon = this!.last;
    while (lastPokemon.forms.isNotEmpty) {
      lastPokemon = lastPokemon.forms.last;
    }
    if (lastPokemon == currentPokemon) return true;
    return false;
  }
}

containsType(List<String> filterTypes, List<PokemonType?> pkmTypes) {
  if (!filterTypes.contains(pkmTypes[0]!.name)) return false;
  if (filterTypes.length == 2 && pkmTypes[1] == null) return false;
  if (filterTypes.length == 1 && pkmTypes[1] != null) return false;
  if (filterTypes.length == 2 && pkmTypes[1] != null) {
    if (!filterTypes.contains(pkmTypes[1]!.name)) return false;
  }
  return true;
}
