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
      case "Pokemon Brilliant Diamond":
        return const Color.fromARGB(255, 63, 90, 241);
      case "Pokemon Shining Pearl":
        return const Color.fromARGB(255, 232, 172, 234);
      case "Pokemon Red":
        return const Color(0xffc03a2d);
      case "Pokemon Blue (Int)":
        return const Color(0xff23409a);
      case "Pokemon Yellow":
        return const Color(0xffddbf2d);
      case "Pokemon Green (Jp)":
        return const Color(0xff43913f);
      case "Pokemon Gold":
        return const Color(0xffdfc832);
      case "Pokemon Silver":
        return const Color(0xffd2e3f1);
      case "Pokemon Crystal":
        return const Color(0xffe8eaf0);
      case "Pokemon Omega Ruby":
        return const Color(0xff4e0505);
      case "Pokemon Ruby":
        return const Color(0xffb83f33);
      case "Pokemon Alpha Sapphire":
        return const Color(0xff07256c);
      case "Pokemon Sapphire":
        return const Color(0xff2064a3);
      case "Pokemon Emerald":
        return const Color(0xff1f5a4d);
      case "Pokemon FireRed":
        return const Color(0xff995024);
      case "Pokemon LeafGreen":
        return const Color(0xff9bb45d);
      case "Pokemon Diamond":
        return const Color(0xffd9c8bc);
      case "Pokemon Pearl":
        return const Color(0xff536d8d);
      case "Pokemon Platinum":
        return const Color(0xff6e6462);
      case "Pokemon HeartGold":
        return const Color(0xffd2ad3d);
      case "Pokemon SoulSilver":
        return const Color(0xffc4c3cb);
      case "Pokemon Black":
      case "Pokemon Black 2":
        return const Color(0xffcfd4ce);
      case "Pokemon White":
      case "Pokemon White 2":
        return const Color(0xff4a5a5b);
      case "Pokemon HOME":
        return const Color.fromARGB(255, 118, 221, 151);
      case "Pokemon Go":
      default:
        return Colors.black;
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
      case "Diamond Exclusive":
        return Game.gameColor("Pokemon Brilliant Diamond");
      case "Pearl Exclusive":
        return Game.gameColor("Pokemon Shining Pearl");
      case "Trade Only":
        return const Color.fromARGB(255, 115, 109, 115);
      case "Event":
        return const Color.fromARGB(255, 199, 72, 210);
      case "Pokemon HOME":
        return Game.gameColor("Pokemon HOME");
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
      case "Pokemon Brilliant Diamond":
        return path += "pokemon_brilliant_diamond.png";
      case "Pokemon Shining Pearl":
        return path += "pokemon_shining_pearl.png";
      case "Pokemon Go":
        return path += "pokemon_go.png";
      case "Pokemon Y":
        return path += "pokemon_y.png";
      case "Pokemon X":
        return path += "pokemon_x.png";
      case "Pokemon Red":
        return path += "pokemon_red.png";
      case "Pokemon Blue (Int)":
        return path += "pokemon_blue.png";
      case "Pokemon Yellow":
        return path += "pokemon_yellow.png";
      case "Pokemon Green (Jp)":
        return path += "pokemon_green.png";
      case "Pokemon Gold":
        return path += "pokemon_gold.png";
      case "Pokemon Silver":
        return path += "pokemon_silver.png";
      case "Pokemon Crystal":
        return path += "pokemon_crystal.png";
      case "Pokemon Ruby":
        return path += "pokemon_ruby.png";
      case "Pokemon Sapphire":
        return path += "pokemon_sapphire.png";
      case "Pokemon Emerald":
        return path += "pokemon_emerald.png";
      case "Pokemon FireRed":
        return path += "pokemon_fireRed.png";
      case "Pokemon LeafGreen":
        return path += "pokemon_leafGreen.png";
      case "Pokemon Diamond":
        return path += "pokemon_diamon.png";
      case "Pokemon Pearl":
        return path += "pokemon_pearl.png";
      case "Pokemon Platinum":
        return path += "pokemon_platinum.png";
      case "Pokemon HeartGold":
        return path += "pokemon_heartGold.png";
      case "Pokemon SoulSilver":
        return path += "pokemon_soulSilver.png";
      case "Pokemon Black":
        return path += "pokemon_black.png";
      case "Pokemon Black 2":
        return path += "pokemon_black2.png";
      case "Pokemon White":
        return path += "pokemon_white.png";
      case "Pokemon White 2":
        return path += "pokemon_white2.png";
      case "Pokemon HOME":
        return path += "pokemon_home.png";
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
      "Pokemon Red",
      "Pokemon Blue (Int)",
      "Pokemon Green (Jp)",
      "Pokemon Yellow",
      "Pokemon Gold",
      "Pokemon Silver",
      "Pokemon Crystal",
      "Pokemon Ruby",
      "Pokemon Sapphire",
      "Pokemon Emerald",
      "Pokemon FireRed",
      "Pokemon LeafGreen",
      "Pokemon Diamond",
      "Pokemon Pearl",
      "Pokemon Platinum",
      "Pokemon HeartGold",
      "Pokemon SoulSilver",
      "Pokemon Black",
      "Pokemon White",
      "Pokemon Black 2",
      "Pokemon White 2",
      "Pokemon X",
      "Pokemon Y",
      "Pokemon Omega Ruby",
      "Pokemon Alpha Sapphire",
      "Pokemon Sun",
      "Pokemon Moon",
      "Pokemon Ultra Sun",
      "Pokemon Ultra Moon",
      "Let's Go Pikachu",
      "Let's Go Eevee",
      "Pokemon Sword",
      "Pokemon Shield",
      "Pokemon Brilliant Diamond",
      "Pokemon Shining Pearl",
      "Pokemon Legends: Arceus",
      "Pokemon Scarlet",
      "Pokemon Violet",
      "Pokemon HOME",
    ];
  }

  static List<String> allGames() {
    return [
      ...availableGames(),
      "Pokemon Go",
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
      case "Pokemon Ruby":
      case "Pokemon Sapphire":
      case "Pokemon Emerald":
      case "Pokemon FireRed":
      case "Pokemon LeafGreen":
      case "Pokemon Brilliant Diamond":
      case "Pokemon Shining Pearl":
        dex.addAll(["National Dex"]);
        break;
      case "Pokemon HOME":
        dex = ['Full Dex'];
        break;
      case "Pokemon Omega Ruby":
      case "Pokemon Alpha Sapphire":
        dex.addAll(["Megas"]);
        break;
      case "Pokemon X":
      case "Pokemon Y":
        dex = ['Central', 'Coastal', 'Mountain', 'Megas'];
        break;
      case "Pokemon Sun":
      case "Pokemon Moon":
      case "Pokemon Ultra Sun":
      case "Pokemon Ultra Moon":
        dex.addAll([
          'Melemele Island',
          'Akala Island',
          'Ula\'Ula Island',
          'Poni Island'
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
      case "Megas":
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
