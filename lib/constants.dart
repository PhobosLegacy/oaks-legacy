import 'package:oaks_legacy/models/preferences.dart';
import 'package:oaks_legacy/models/flag.dart';
import 'models/pokemon.dart';

const String kSupabaseUrl = 'https://gfoeebribnlwseyepwlx.supabase.co';
const String kSupabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdmb2VlYnJpYm5sd3NleWVwd2x4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3NTEwMTQsImV4cCI6MjAyNjMyNzAxNH0.x8KDWj1iJe3Wo24Br-xfsbRVAcHQdCQUyDS6QBqKHgo';
const String kPokedexFileLocation = 'data/pokedex.json';

const String kImagesRoot = 'images/';
const String kImageLocalPrefix =
    "https://gfoeebribnlwseyepwlx.supabase.co/storage/v1/object/public/";
// "https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/Art/";

const String kServerVersionLocation =
    'https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ServerVersions/versions.json';

const String kServerPokedexLocation =
    'https://gfoeebribnlwseyepwlx.supabase.co/storage/v1/object/public/resources/pokedex.json';
//  'https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ServerVersions/pokedex.json';

const String kFlagsKey = 'flags';
const String kPreferencesKey = 'userPreferences';
const String kCollectionKey = 'collections';
const String kLookingFor = 'lookingFor';
const String kForTrade = 'forTrade';
const String kTrackersKey = 'trackers';

const String kTrackerPrefix = 't_';
const String kVersionsKey = 'versions';
const String kPokedexKey = 'pokedex';

const String kValueNotFound = "?";

List<Pokemon> kPokedex = [];

late Preferences kPreferences;
late Flags kFlags;

List<double> kBreakpoints = [768, 1024, 1440];
