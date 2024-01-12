/*
  Useful:
  // debugPrint(jsonEncode(pokemonFromDex));
  // debugPrint("DIVIDER");
  // debugPrint(jsonEncode(pokemonFromTestFile));
  // Map<String, dynamic> testPokemon = jsonDecode(testPokemonFile);
*/

//Sample from how pokemon looks after createPokedex is applied.
List<Map<String, dynamic>> createPokemonPkmSample = [
  {'id': '0001', 'name': 'create_pokedex_bulbasaur'}, //No forms
  {'id': '0003', 'name': 'create_pokedex_venusaur'}, //Forms: Mega, Dyna
  {'id': '0128', 'name': 'create_pokedex_tauros'}, //2 level deep forms
  {'id': '0892', 'name': 'create_pokedex_urshifu'}, //Main contained in forms
  {'id': '0869', 'name': 'create_pokedex_alcremie'}, //Main contained in forms
  {'id': '0418', 'name': 'create_pokedex_buizel'}, //Item adds forms
  {'id': '1008', 'name': 'create_pokedex_miraidon'}, //No shiny available
];

List<Map<String, dynamic>> keepForms = [
  {'value': true},
  {'value': false},
];
