import 'package:oaks_legacy/models/news.dart';
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

const kDonateLink = 'https://buymeacoffee.com/phoboslegacy';

const String kFlagsKey = 'system_flags';
const String kNewsKey = 'system_news';
const String kPreferencesKey = 'user_preferences';
const String kMessagesKey = 'user_messages';
const String kCollectionKey = 'user_collections';
const String kLookingFor = 'user_lookingFor';
const String kForTrade = 'user_forTrade';
const String kTrackersKey = 'user_trackers';

const String kTrackerPrefix = 't_';
const String kVersionsKey = 'versions';
const String kPokedexKey = 'pokedex';

const String kValueNotFound = "?";

List<Pokemon> kPokedex = [];

const int kMaxNumberOfMessagesDaily = 5;

late Preferences kPreferences;
late Flags kFlags;
late List<News> kNews;

List<double> kBreakpoints = [768, 1024, 1440];
String loggedUserId = '';
const String tempUser = '14c92086-32ef-47bb-8b8b-02341b30840e';
