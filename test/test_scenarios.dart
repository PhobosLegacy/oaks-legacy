/*
  Useful:
  // debugPrint(jsonEncode(pokemonFromDex));
  // debugPrint("DIVIDER");
  // debugPrint(jsonEncode(pokemonFromTestFile));
  // Map<String, dynamic> testPokemon = jsonDecode(testPokemonFile);
*/

//Sample from how pokemon looks after createPokedex is applied.
import "package:oaks_legacy/models/enums.dart";

List<Map<String, dynamic>> createPokemonPkmSample = [
  {"id": "0001", "name": "create_pokedex_bulbasaur"}, //No forms
  {"id": "0003", "name": "create_pokedex_venusaur"}, //Forms: Mega, Dyna
  {"id": "0128", "name": "create_pokedex_tauros"}, //2 level deep forms
  {"id": "0892", "name": "create_pokedex_urshifu"}, //Main contained in forms
  {"id": "0869", "name": "create_pokedex_alcremie"}, //Main contained in forms
  {"id": "0418", "name": "create_pokedex_buizel"}, //Item adds forms
  {"id": "1008", "name": "create_pokedex_miraidon"}, //No shiny available
];

List<Map<String, dynamic>> itemPokemonPkmSample = [
  {
    "id": "0001",
    "useGameNumber": false,
    "gender": PokemonGender.undefinied
  }, //Bulbasaur - Use Game Number False //Form is empty //Male/Female Pokemon
  {
    "id": "0128",
    "useGameNumber": true,
    "gender": PokemonGender.male
  }, //Tauros - Use Game Number True //Form has value //Only male Pokemon
  {
    "id": "0144",
    "useGameNumber": true,
    "gender": PokemonGender.genderless
  }, //Koraidon - Genderless Pokemon
  {
    "id": "0113",
    "useGameNumber": false,
    "gender": PokemonGender.female
  }, //Chansey - Only female Pokemon
];

List<Map<String, dynamic>> itemPkmSample = [
  {"name": "item_starly"},
  {"name": "item_rowlet"}
];

List<Map<String, dynamic>> keepForms = [
  {"value": true},
  {"value": false},
];

List<Map<String, dynamic>> trackers = [
  {
    "testFileName": "LegendsArceusRegionalBasic",
    "trackerName": "Legends:Arceus-Regional-Basic",
    "gameName": "Pokemon Legends: Arceus",
    "dexName": "Regional",
    "trackerType": "Basic",
    "lenght": 242
  },
  {
    "testFileName": "LegendsArceusRegionalShiny",
    "trackerName": "Legends:Arceus-Regional-Shiny",
    "gameName": "Pokemon Legends: Arceus",
    "dexName": "Regional",
    "trackerType": "Shiny",
    "lenght": 224
  },
  {
    "testFileName": "LegendsArceusRegionalLivingDex",
    "trackerName": "Legends:Arceus-Regional-LivingDex",
    "gameName": "Pokemon Legends: Arceus",
    "dexName": "Regional",
    "trackerType": "Living Dex",
    "lenght": 242
  },
  {
    "testFileName": "LegendsArceusRegionalShinyLivingDex",
    "trackerName": "Legends:Arceus-Regional-ShinyLivingDex",
    "gameName": "Pokemon Legends: Arceus",
    "dexName": "Regional",
    "trackerType": "Shiny Living Dex",
    "lenght": 224
  },
  {
    "testFileName": "LetsGoEeveeRegionalBasic",
    "trackerName": "Let'sGoEevee-Regional-Basic",
    "gameName": "Let's Go Eevee",
    "dexName": "Regional",
    "trackerType": "Basic",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoEeveeRegionalShiny",
    "trackerName": "Let'sGoEevee-Regional-Shiny",
    "gameName": "Let's Go Eevee",
    "dexName": "Regional",
    "trackerType": "Shiny",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoEeveeRegionalLivingDex",
    "trackerName": "Let'sGoEevee-Regional-LivingDex",
    "gameName": "Let's Go Eevee",
    "dexName": "Regional",
    "trackerType": "Living Dex",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoEeveeRegionalShinyLivingDex",
    "trackerName": "Let'sGoEevee-Regional-ShinyLivingDex",
    "gameName": "Let's Go Eevee",
    "dexName": "Regional",
    "trackerType": "Shiny Living Dex",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoEeveeAlolanBasic",
    "trackerName": "Let'sGoEevee-Alolan-Basic",
    "gameName": "Let's Go Eevee",
    "dexName": "Alolan",
    "trackerType": "Basic",
    "lenght": 18
  },
  {
    "testFileName": "LetsGoEeveeAlolanShiny",
    "trackerName": "Let'sGoEevee-Alolan-Shiny",
    "gameName": "Let's Go Eevee",
    "dexName": "Alolan",
    "trackerType": "Shiny",
    "lenght": 18
  },
  {
    "testFileName": "LetsGoEeveeOthersOthers",
    "trackerName": "Let'sGoEevee-Others-Others",
    "gameName": "Let's Go Eevee",
    "dexName": "Others",
    "trackerType": "Others",
    "lenght": 3
  },
  {
    "testFileName": "LetsGoPikachuRegionalBasic",
    "trackerName": "Let'sGoPikachu-Regional-Basic",
    "gameName": "Let's Go Pikachu",
    "dexName": "Regional",
    "trackerType": "Basic",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoPikachuRegionalShiny",
    "trackerName": "Let'sGoPikachu-Regional-Shiny",
    "gameName": "Let's Go Pikachu",
    "dexName": "Regional",
    "trackerType": "Shiny",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoPikachuRegionalLivingDex",
    "trackerName": "Let'sGoPikachu-Regional-LivingDex",
    "gameName": "Let's Go Pikachu",
    "dexName": "Regional",
    "trackerType": "Living Dex",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoPikachuRegionalShinyLivingDex",
    "trackerName": "Let'sGoPikachu-Regional-ShinyLivingDex",
    "gameName": "Let's Go Pikachu",
    "dexName": "Regional",
    "trackerType": "Shiny Living Dex",
    "lenght": 150
  },
  {
    "testFileName": "LetsGoPikachuAlolanBasic",
    "trackerName": "Let'sGoPikachu-Alolan-Basic",
    "gameName": "Let's Go Pikachu",
    "dexName": "Alolan",
    "trackerType": "Basic",
    "lenght": 18
  },
  {
    "testFileName": "LetsGoPikachuAlolanShiny",
    "trackerName": "Let'sGoPikachu-Alolan-Shiny",
    "gameName": "Let's Go Pikachu",
    "dexName": "Alolan",
    "trackerType": "Shiny",
    "lenght": 18
  },
  {
    "testFileName": "LetsGoPikachuOthersOthers",
    "trackerName": "Let'sGoPikachu-Others-Others",
    "gameName": "Let's Go Pikachu",
    "dexName": "Others",
    "trackerType": "Others",
    "lenght": 3
  },
  {
    "testFileName": "VioletRegionalBasic",
    "trackerName": "Violet-Regional-Basic",
    "gameName": "Pokemon Violet",
    "dexName": "Regional",
    "trackerType": "Basic",
    "lenght": 400
  },
  {
    "testFileName": "VioletRegionalShiny",
    "trackerName": "Violet-Regional-Shiny",
    "gameName": "Pokemon Violet",
    "dexName": "Regional",
    "trackerType": "Shiny",
    "lenght": 392
  },
  {
    "testFileName": "VioletRegionalLivingDex",
    "trackerName": "Violet-Regional-LivingDex",
    "gameName": "Pokemon Violet",
    "dexName": "Regional",
    "trackerType": "Living Dex",
    "lenght": 400
  },
  {
    "testFileName": "VioletRegionalShinyLivingDex",
    "trackerName": "Violet-Regional-ShinyLivingDex",
    "gameName": "Pokemon Violet",
    "dexName": "Regional",
    "trackerType": "Shiny Living Dex",
    "lenght": 392
  },
  {
    "testFileName": "ScarletRegionalBasic",
    "trackerName": "Scarlet-Regional-Basic",
    "gameName": "Pokemon Scarlet",
    "dexName": "Regional",
    "trackerType": "Basic",
    "lenght": 400
  },
  {
    "testFileName": "ScarletRegionalShiny",
    "trackerName": "Scarlet-Regional-Shiny",
    "gameName": "Pokemon Scarlet",
    "dexName": "Regional",
    "trackerType": "Shiny",
    "lenght": 392
  },
  {
    "testFileName": "ScarletRegionalLivingDex",
    "trackerName": "Scarlet-Regional-LivingDex",
    "gameName": "Pokemon Scarlet",
    "dexName": "Regional",
    "trackerType": "Living Dex",
    "lenght": 400
  },
  {
    "testFileName": "ScarletRegionalShinyLivingDex",
    "trackerName": "Scarlet-Regional-ShinyLivingDex",
    "gameName": "Pokemon Scarlet",
    "dexName": "Regional",
    "trackerType": "Shiny Living Dex",
    "lenght": 392
  },
  {
    "testFileName": "VioletKitakamiBasic",
    "trackerName": "Violet-Kitakami-Basic",
    "gameName": "Pokemon Violet",
    "dexName": "Kitakami",
    "trackerType": "Basic",
    "lenght": 200
  },
  {
    "testFileName": "VioletKitakamiShiny",
    "trackerName": "Violet-Kitakami-Shiny",
    "gameName": "Pokemon Violet",
    "dexName": "Kitakami",
    "trackerType": "Shiny",
    "lenght": 195
  },
  {
    "testFileName": "VioletKitakamiLivingDex",
    "trackerName": "Violet-Kitakami-LivingDex",
    "gameName": "Pokemon Violet",
    "dexName": "Kitakami",
    "trackerType": "Living Dex",
    "lenght": 200
  },
  {
    "testFileName": "VioletKitakamiShinyLivingDex",
    "trackerName": "Violet-Kitakami-ShinyLivingDex",
    "gameName": "Pokemon Violet",
    "dexName": "Kitakami",
    "trackerType": "Shiny Living Dex",
    "lenght": 195
  },
  {
    "testFileName": "ScarletKitakamiBasic",
    "trackerName": "Scarlet-Kitakami-Basic",
    "gameName": "Pokemon Scarlet",
    "dexName": "Kitakami",
    "trackerType": "Basic",
    "lenght": 200
  },
  {
    "testFileName": "ScarletKitakamiShiny",
    "trackerName": "Scarlet-Kitakami-Shiny",
    "gameName": "Pokemon Scarlet",
    "dexName": "Kitakami",
    "trackerType": "Shiny",
    "lenght": 195
  },
  {
    "testFileName": "ScarletKitakamiLivingDex",
    "trackerName": "Scarlet-Kitakami-LivingDex",
    "gameName": "Pokemon Scarlet",
    "dexName": "Kitakami",
    "trackerType": "Living Dex",
    "lenght": 200
  },
  {
    "testFileName": "ScarletKitakamiShinyLivingDex",
    "trackerName": "Scarlet-Kitakami-ShinyLivingDex",
    "gameName": "Pokemon Scarlet",
    "dexName": "Kitakami",
    "trackerType": "Shiny Living Dex",
    "lenght": 195
  },
  {
    "testFileName": "VioletBlueberryBasic",
    "trackerName": "Violet-Blueberry-Basic",
    "gameName": "Pokemon Violet",
    "dexName": "Blueberry",
    "trackerType": "Basic",
    "lenght": 242
  },
  {
    "testFileName": "VioletBlueberryShiny",
    "trackerName": "Violet-Blueberry-Shiny",
    "gameName": "Pokemon Violet",
    "dexName": "Blueberry",
    "trackerType": "Shiny",
    "lenght": 235
  },
  {
    "testFileName": "VioletBlueberryLivingDex",
    "trackerName": "Violet-Blueberry-LivingDex",
    "gameName": "Pokemon Violet",
    "dexName": "Blueberry",
    "trackerType": "Living Dex",
    "lenght": 242
  },
  {
    "testFileName": "VioletBlueberryShinyLivingDex",
    "trackerName": "Violet-Blueberry-ShinyLivingDex",
    "gameName": "Pokemon Violet",
    "dexName": "Blueberry",
    "trackerType": "Shiny Living Dex",
    "lenght": 235
  },
  {
    "testFileName": "ScarletBlueberryBasic",
    "trackerName": "Scarlet-Blueberry-Basic",
    "gameName": "Pokemon Scarlet",
    "dexName": "Blueberry",
    "trackerType": "Basic",
    "lenght": 242
  },
  {
    "testFileName": "ScarletBlueberryShiny",
    "trackerName": "Scarlet-Blueberry-Shiny",
    "gameName": "Pokemon Scarlet",
    "dexName": "Blueberry",
    "trackerType": "Shiny",
    "lenght": 235
  },
  {
    "testFileName": "ScarletBlueberryLivingDex",
    "trackerName": "Scarlet-Blueberry-LivingDex",
    "gameName": "Pokemon Scarlet",
    "dexName": "Blueberry",
    "trackerType": "Living Dex",
    "lenght": 242
  },
  {
    "testFileName": "ScarletBlueberryShinyLivingDex",
    "trackerName": "Scarlet-Blueberry-ShinyLivingDex",
    "gameName": "Pokemon Scarlet",
    "dexName": "Blueberry",
    "trackerType": "Shiny Living Dex",
    "lenght": 235
  },
  {
    "testFileName": "VioletVivillonsBasic",
    "trackerName": "Violet-Vivillons-Basic",
    "gameName": "Pokemon Violet",
    "dexName": "Vivillons",
    "trackerType": "Basic",
    "lenght": 19
  },
  {
    "testFileName": "VioletVivillonsShiny",
    "trackerName": "Violet-Vivillons-Shiny",
    "gameName": "Pokemon Violet",
    "dexName": "Vivillons",
    "trackerType": "Shiny",
    "lenght": 19
  },
  {
    "testFileName": "ScarletVivillonsBasic",
    "trackerName": "Scarlet-Vivillons-Basic",
    "gameName": "Pokemon Scarlet",
    "dexName": "Vivillons",
    "trackerType": "Basic",
    "lenght": 19
  },
  {
    "testFileName": "ScarletVivillonsShiny",
    "trackerName": "Scarlet-Vivillons-Shiny",
    "gameName": "Pokemon Scarlet",
    "dexName": "Vivillons",
    "trackerType": "Shiny",
    "lenght": 19
  },
  {
    "testFileName": "VioletMightiestMarkBasic",
    "trackerName": "Violet-MightiestMark-Basic",
    "gameName": "Pokemon Violet",
    "dexName": "Mightiest Mark",
    "trackerType": "Basic",
    "lenght": 18
  },
  {
    "testFileName": "ScarletMightiestMarkBasic",
    "trackerName": "Scarlet-MightiestMark-Basic",
    "gameName": "Pokemon Scarlet",
    "dexName": "Mightiest Mark",
    "trackerType": "Basic",
    "lenght": 18
  },
  {
    "testFileName": "SwordRegionalBasic",
    "trackerName": "Sword-Regional-Basic",
    "gameName": "Pokemon Sword",
    "dexName": "Regional",
    "trackerType": "Basic",
    "lenght": 400
  },
  {
    "testFileName": "SwordRegionalShiny",
    "trackerName": "Sword-Regional-Shiny",
    "gameName": "Pokemon Sword",
    "dexName": "Regional",
    "trackerType": "Shiny",
    "lenght": 395
  },
  {
    "testFileName": "SwordRegionalLivingDex",
    "trackerName": "Sword-Regional-LivingDex",
    "gameName": "Pokemon Sword",
    "dexName": "Regional",
    "trackerType": "Living Dex",
    "lenght": 400
  },
  {
    "testFileName": "SwordRegionalShinyLivingDex",
    "trackerName": "Sword-Regional-ShinyLivingDex",
    "gameName": "Pokemon Sword",
    "dexName": "Regional",
    "trackerType": "Shiny Living Dex",
    "lenght": 395
  },
  {
    "testFileName": "ShieldRegionalBasic",
    "trackerName": "Shield-Regional-Basic",
    "gameName": "Pokemon Shield",
    "dexName": "Regional",
    "trackerType": "Basic",
    "lenght": 400
  },
  {
    "testFileName": "ShieldRegionalShiny",
    "trackerName": "Shield-Regional-Shiny",
    "gameName": "Pokemon Shield",
    "dexName": "Regional",
    "trackerType": "Shiny",
    "lenght": 395
  },
  {
    "testFileName": "ShieldRegionalLivingDex",
    "trackerName": "Shield-Regional-LivingDex",
    "gameName": "Pokemon Shield",
    "dexName": "Regional",
    "trackerType": "Living Dex",
    "lenght": 400
  },
  {
    "testFileName": "ShieldRegionalShinyLivingDex",
    "trackerName": "Shield-Regional-ShinyLivingDex",
    "gameName": "Pokemon Shield",
    "dexName": "Regional",
    "trackerType": "Shiny Living Dex",
    "lenght": 395
  },
  {
    "testFileName": "SwordIsleofArmorBasic",
    "trackerName": "Sword-IsleofArmor-Basic",
    "gameName": "Pokemon Sword",
    "dexName": "Isle of Armor",
    "trackerType": "Basic",
    "lenght": 211
  },
  {
    "testFileName": "SwordIsleofArmorShiny",
    "trackerName": "Sword-IsleofArmor-Shiny",
    "gameName": "Pokemon Sword",
    "dexName": "Isle of Armor",
    "trackerType": "Shiny",
    "lenght": 210
  },
  {
    "testFileName": "SwordIsleofArmorLivingDex",
    "trackerName": "Sword-IsleofArmor-LivingDex",
    "gameName": "Pokemon Sword",
    "dexName": "Isle of Armor",
    "trackerType": "Living Dex",
    "lenght": 211
  },
  {
    "testFileName": "SwordIsleofArmorShinyLivingDex",
    "trackerName": "Sword-IsleofArmor-ShinyLivingDex",
    "gameName": "Pokemon Sword",
    "dexName": "Isle of Armor",
    "trackerType": "Shiny Living Dex",
    "lenght": 210
  },
  {
    "testFileName": "ShieldIsleofArmorBasic",
    "trackerName": "Shield-IsleofArmor-Basic",
    "gameName": "Pokemon Shield",
    "dexName": "Isle of Armor",
    "trackerType": "Basic",
    "lenght": 211
  },
  {
    "testFileName": "ShieldIsleofArmorShiny",
    "trackerName": "Shield-IsleofArmor-Shiny",
    "gameName": "Pokemon Shield",
    "dexName": "Isle of Armor",
    "trackerType": "Shiny",
    "lenght": 210
  },
  {
    "testFileName": "ShieldIsleofArmorLivingDex",
    "trackerName": "Shield-IsleofArmor-LivingDex",
    "gameName": "Pokemon Shield",
    "dexName": "Isle of Armor",
    "trackerType": "Living Dex",
    "lenght": 211
  },
  {
    "testFileName": "ShieldIsleofArmorShinyLivingDex",
    "trackerName": "Shield-IsleofArmor-ShinyLivingDex",
    "gameName": "Pokemon Shield",
    "dexName": "Isle of Armor",
    "trackerType": "Shiny Living Dex",
    "lenght": 210
  },
  {
    "testFileName": "SwordCrownTundraBasic",
    "trackerName": "Sword-CrownTundra-Basic",
    "gameName": "Pokemon Sword",
    "dexName": "Crown Tundra",
    "trackerType": "Basic",
    "lenght": 210
  },
  {
    "testFileName": "SwordCrownTundraShiny",
    "trackerName": "Sword-CrownTundra-Shiny",
    "gameName": "Pokemon Sword",
    "dexName": "Crown Tundra",
    "trackerType": "Shiny",
    "lenght": 204
  },
  {
    "testFileName": "SwordCrownTundraLivingDex",
    "trackerName": "Sword-CrownTundra-LivingDex",
    "gameName": "Pokemon Sword",
    "dexName": "Crown Tundra",
    "trackerType": "Living Dex",
    "lenght": 210
  },
  {
    "testFileName": "SwordCrownTundraShinyLivingDex",
    "trackerName": "Sword-CrownTundra-ShinyLivingDex",
    "gameName": "Pokemon Sword",
    "dexName": "Crown Tundra",
    "trackerType": "Shiny Living Dex",
    "lenght": 204
  },
  {
    "testFileName": "ShieldCrownTundraBasic",
    "trackerName": "Shield-CrownTundra-Basic",
    "gameName": "Pokemon Shield",
    "dexName": "Crown Tundra",
    "trackerType": "Basic",
    "lenght": 210
  },
  {
    "testFileName": "ShieldCrownTundraShiny",
    "trackerName": "Shield-CrownTundra-Shiny",
    "gameName": "Pokemon Shield",
    "dexName": "Crown Tundra",
    "trackerType": "Shiny",
    "lenght": 204
  },
  {
    "testFileName": "ShieldCrownTundraLivingDex",
    "trackerName": "Shield-CrownTundra-LivingDex",
    "gameName": "Pokemon Shield",
    "dexName": "Crown Tundra",
    "trackerType": "Living Dex",
    "lenght": 210
  },
  {
    "testFileName": "ShieldCrownTundraShinyLivingDex",
    "trackerName": "Shield-CrownTundra-ShinyLivingDex",
    "gameName": "Pokemon Shield",
    "dexName": "Crown Tundra",
    "trackerType": "Shiny Living Dex",
    "lenght": 204
  },
  {
    "testFileName": "ShieldGigantamaxFormsBasic",
    "trackerName": "Shield-GigantamaxForms-Basic",
    "gameName": "Pokemon Shield",
    "dexName": "Gigantamax Forms",
    "trackerType": "Basic",
    "lenght": 33
  },
  {
    "testFileName": "ShieldGigantamaxFormsShiny",
    "trackerName": "Shield-GigantamaxForms-Shiny",
    "gameName": "Pokemon Shield",
    "dexName": "Gigantamax Forms",
    "trackerType": "Shiny",
    "lenght": 31
  },
  {
    "testFileName": "SwordDynamaxAdventureBossesBasic",
    "trackerName": "Sword-DynamaxAdventureBosses-Basic",
    "gameName": "Pokemon Sword",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Basic",
    "lenght": 47
  },
  {
    "testFileName": "SwordDynamaxAdventureBossesShiny",
    "trackerName": "Sword-DynamaxAdventureBosses-Shiny",
    "gameName": "Pokemon Sword",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Shiny",
    "lenght": 47
  },
  {
    "testFileName": "ShieldDynamaxAdventureBossesBasic",
    "trackerName": "Shield-DynamaxAdventureBosses-Basic",
    "gameName": "Pokemon Shield",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Basic",
    "lenght": 47
  },
  {
    "testFileName": "ShieldDynamaxAdventureBossesShiny",
    "trackerName": "Shield-DynamaxAdventureBosses-Shiny",
    "gameName": "Pokemon Shield",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Shiny",
    "lenght": 47
  },
];

List<Map<String, dynamic>> createTrackers = [
  {
    "gameName": "Pokemon Sword",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Basic",
  },
  {
    "gameName": "Pokemon Sword",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Shiny",
  },
  {
    "gameName": "Pokemon Shield",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Basic",
  },
  {
    "gameName": "Pokemon Shield",
    "dexName": "Dynamax Adventure Bosses",
    "trackerType": "Shiny",
  },
];
