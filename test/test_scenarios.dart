/*
  Useful:
  // debugPrint(jsonEncode(pokemonFromDex));
  // debugPrint("DIVIDER");
  // debugPrint(jsonEncode(pokemonFromTestFile));
  // Map<String, dynamic> testPokemon = jsonDecode(testPokemonFile);
*/

//Sample from how pokemon looks after createPokedex is applied.
import 'package:oaks_legacy/models/enums.dart';

List<Map<String, dynamic>> createPokemonPkmSample = [
  {'id': '0001', 'name': 'create_pokedex_bulbasaur'}, //No forms
  {'id': '0003', 'name': 'create_pokedex_venusaur'}, //Forms: Mega, Dyna
  {'id': '0128', 'name': 'create_pokedex_tauros'}, //2 level deep forms
  {'id': '0892', 'name': 'create_pokedex_urshifu'}, //Main contained in forms
  {'id': '0869', 'name': 'create_pokedex_alcremie'}, //Main contained in forms
  {'id': '0418', 'name': 'create_pokedex_buizel'}, //Item adds forms
  {'id': '1008', 'name': 'create_pokedex_miraidon'}, //No shiny available
];

List<Map<String, dynamic>> itemPokemonPkmSample = [
  {
    'id': '0001',
    'useGameNumber': false,
    'gender': PokemonGender.undefinied
  }, //Bulbasaur - Use Game Number False //Form is empty //Male/Female Pokemon
  {
    'id': '0128',
    'useGameNumber': true,
    'gender': PokemonGender.male
  }, //Tauros - Use Game Number True //Form has value //Only male Pokemon
  {
    'id': '0144',
    'useGameNumber': true,
    'gender': PokemonGender.genderless
  }, //Koraidon - Genderless Pokemon
  {
    'id': '0113',
    'useGameNumber': false,
    'gender': PokemonGender.female
  }, //Chansey - Only female Pokemon
];

List<Map<String, dynamic>> itemPkmSample = [
  {'name': 'item_starly'},
  {'name': 'item_rowlet'}
];

List<Map<String, dynamic>> keepForms = [
  {'value': true},
  {'value': false},
];
