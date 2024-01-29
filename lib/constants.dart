import 'package:oaks_legacy/models/preferences.dart';

import 'models/pokemon.dart';

const String kPokedexFileLocation = 'data/pokedex.json';

const String kImagesRoot = 'images/';
const String kImageLocalPrefix =
    "https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/Art/";
const String kServerVersionLocation =
    'https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ServerVersions/versions.json';
const String kServerPokedexLocation =
    'https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ServerVersions/pokedex.json';

const String kServerPreferences =
    'https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ServerVersions/preferences.json';
const String kTrackerPrefix = 't_';
// const String kCollectionBaseName = 'c_myCollection.json';
// const String kLookingForBaseName = 'c_lookingFor.json';
// const String kForTradeBaseName = 'c_forTrade.json';

const String kPreferencesKey = 'preferences';
const String kVersionsKey = 'versions';
const String kPokedexKey = 'pokedex';
const String kCollectionKey = 'collection';
const String kLookingFor = 'lookingFor';
const String kForTrade = 'forTrade';

const String kValueNotFound = "?";

List<Pokemon> kPokedex = [];

late Preferences kPreferences;

List<double> kBreakpoints = [768, 1024, 1440];
