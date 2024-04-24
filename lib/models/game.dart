import 'package:flutter/material.dart';

class Game extends Dex {
  Game(
      {required super.name,
      required super.dex,
      required this.number,
      required this.notes,
      required this.shinyLocked})
      : super();

  final String number;
  final String notes;
  final String shinyLocked;

  Game.fromJson(super.json)
      : number = json['number'],
        notes = json['notes'],
        shinyLocked = json['shinyLocked'],
        super.fromJson();

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dex': dex,
      'number': number,
      'shinyLocked': shinyLocked,
      'notes': notes,
    };
  }

  static gameColor(gameName) {
    switch (gameName) {
      case "Pokemon Scarlet":
        return Colors.red;
      case "Pokemon Violet":
        return Colors.purple;
      case "Let's Go Pikachu":
        return const Color.fromARGB(255, 208, 192, 46);
      case "Let's Go Eevee":
        return Colors.brown;
      case "Pokemon Sword":
        return Colors.lightBlueAccent;
      case "Pokemon Shield":
        return Colors.redAccent;
      case "Pokemon Home":
        return Colors.greenAccent;
      case "Pokemon Ultra Moon":
      case "Pokemon Moon":
        return const Color.fromARGB(255, 77, 161, 203);
      case "Pokemon Ultra Sun":
      case "Pokemon Sun":
        return const Color.fromARGB(255, 232, 232, 97);
      case "Pokemon Legends: Arceus":
        return const Color.fromARGB(255, 232, 232, 214);
      case "Pokemon Y":
        return const Color.fromARGB(255, 194, 63, 56);
      case "Pokemon X":
        return const Color.fromARGB(255, 59, 40, 178);
      case "Pokemon Omega Ruby":
      case "Pokemon Alpha Sapphire":
      case "Pokemon Brillian Diamond":
      case "Pokemon Shining Pearl":
      case "Pokemon Go":
      default:
        return Colors.blue;
    }
  }

  static getGameExclusiveBannerColor(notes) {
    switch (notes) {
      case "Violet Exclusive":
        return Game.gameColor("Pokemon Violet");
      case "Scarlet Exclusive":
        return Game.gameColor("Pokemon Scarlet");
      case "Sword Exclusive":
        return Game.gameColor("Pokemon Sword");
      case "Shield Exclusive":
        return Game.gameColor("Pokemon Shield");
      case "Pikachu Exclusive":
        return Game.gameColor("Let's Go Pikachu");
      case "Eevee Exclusive":
        return Game.gameColor("Let's Go Eevee");
      default:
        return Colors.black;
    }
  }

  static gameIcon(String gameName) {
    String path = "games/";
    // String path = "";
    switch (gameName) {
      case "Pokemon Scarlet":
        return path += "pokemon_scarlet.png";
      case "Pokemon Violet":
        return path += "pokemon_violet.png";
      case "Let's Go Pikachu":
        return path += "pokemon_lets_go_pikachu.png";
      case "Let's Go Eevee":
        return path += "pokemon_lets_go_eevee.png";
      case "Pokemon Sword":
        return path += "pokemon_sword.png";
      case "Pokemon Shield":
        return path += "pokemon_shield.png";
      case "Pokemon Home":
        return path += "pokemon_home.png";
      case "Pokemon Moon":
        return path += "pokemon_moon.png";
      case "Pokemon Sun":
        return path += "pokemon_sun.png";
      case "Pokemon Ultra Moon":
        return path += "pokemon_ultra_moon.png";
      case "Pokemon Ultra Sun":
        return path += "pokemon_ultra_sun.png";
      case "Pokemon Legends: Arceus":
        return path += "pokemon_legends_arceus.png";
      case "Pokemon Omega Ruby":
        return path += "pokemon_omega_ruby.png";
      case "Pokemon Alpha Sapphire":
        return path += "pokemon_alpha_sapphire.png";
      case "Pokemon Brillian Diamond":
        return path += "pokemon_brilliant_diamond.png";
      case "Pokemon Shining Pearl":
        return path += "pokemon_shining_pearl.png";
      case "Pokemon Go":
        return path += "pokemon_go.png";
      case "Pokemon Y":
        return path += "pokemon_y.png";
      case "Pokemon X":
        return path += "pokemon_x.png";
      default:
        return path += "colored_ball.png";
    }
  }
}

class Dex {
  Dex({required this.name, required this.dex});

  final String name;
  final String dex;

  Dex.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        dex = json['dex'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dex': dex,
    };
  }

  static availableGames() {
    return [
      "Pokemon Scarlet",
      "Pokemon Violet",
      "Pokemon Sword",
      "Pokemon Shield",
      "Let's Go Pikachu",
      "Let's Go Eevee",
      "Pokemon Legends: Arceus"
      // "Pokemon X",
      // "Pokemon Y",
      // "Pokemon Sun",
      // "Pokemon Moon",
      // "Pokemon Ultra Sun",
      // "Pokemon Ultra Moon"
    ];
  }

  static List<String> allGames() {
    return [
      "Pokemon Scarlet",
      "Pokemon Violet",
      "Pokemon Sword",
      "Pokemon Shield",
      "Let's Go Pikachu",
      "Let's Go Eevee",
      "Pokemon X",
      "Pokemon Y",
      "Pokemon Sun",
      "Pokemon Moon",
      "Pokemon Ultra Sun",
      "Pokemon Ultra Moon",
      "Pokemon Legends: Arceus",
      "Pokemon Home",
    ];
  }

  static availableDex(String game) {
    List<String> dex = ["Regional"];

    switch (game) {
      case "Pokemon Scarlet":
      case "Pokemon Violet":
        dex.addAll(["Kitakami", "Blueberry", "Vivillons", "Mightiest Mark"]);
        break;
      case "Let's Go Pikachu":
      case "Let's Go Eevee":
        dex.addAll(["Alolan", "Others"]);
        break;
      case "Pokemon Sword":
      case "Pokemon Shield":
        dex.addAll([
          "Isle of Armor",
          "Crown Tundra",
          "Dynamax Adventure Bosses",
          "Gigantamax Forms"
        ]);
        break;
      default:
    }

    return dex;
  }

  static availableTrackerType(String dexName) {
    switch (dexName) {
      case "Alolan":
      case "Gigantamax Forms":
      case "Vivillons":
      case "Dynamax Adventure Bosses":
        return [
          "Basic",
          "Shiny",
        ];
      case "Mightiest Mark":
        return [
          "Basic",
        ];
      case "Others":
        return [
          "Others",
        ];
      // case "TMs":
      //   return ["TMs"];
      default:
        return [
          "Basic",
          "Shiny",
          "Living Dex",
          "Shiny Living Dex",
        ];
    }
  }
}
