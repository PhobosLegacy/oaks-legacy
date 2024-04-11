import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/flag.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/models/preferences.dart';
import 'package:oaks_legacy/models/tracker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseManager {
  // static late UserData user;

  static initSupabase() async {
    await Supabase.initialize(
      url: kSupabaseUrl,
      anonKey: kSupabaseKey,
    );
  }

  // static signUp() async {
  //   final AuthResponse res = await Supabase.instance.client.auth.signUp(
  //     email: 'icarotor@gmail.com',
  //     password: 'test123',
  //   );
  //   final Session? session = res.session;
  //   final User? user = res.user;
  // }
  // static signIn() async {
  //   final AuthResponse res =
  //       await Supabase.instance.client.auth.signInWithPassword(
  //     email: 'icarotor@gmail.com',
  //     password: 'test123',
  //   );
  //   final Session? session = res.session;
  //   final User? user = res.user;
  // }
  //TEMP Retrieve user info before we set a proper auth
  // // static setUser() async {
  // //   var userRecord = await Supabase.instance.client
  // //       .from('users')
  // //       .select()
  // //       .match({'email': 'admin', 'password': 'admin'}).single();
  // //   user = UserData(
  // //       user: userRecord['email'],
  // //       pass: userRecord['password'],
  // //       identity: userRecord['userIdentity']);
  // // }

  static Future<Flags> getSystemFlags() async {
    var record =
        await Supabase.instance.client.from(kFlagsKey).select().single();

    return Flags.fromDataBase(record);
  }

  static Future<Preferences> getUserPreferences() async {
    var records = await Supabase.instance.client
        .from(kPreferencesKey)
        .select()
        .match({'userIdentity': loggedUserId});

    if (records.isEmpty) {
      var newUserPreferences = await Supabase.instance.client
          .from(kPreferencesKey)
          .insert({
        'userIdentity': loggedUserId,
        'trainerNames': List<String>.empty()
      }).select();

      return Preferences.fromDataBase(newUserPreferences.single);
    } else {
      return Preferences.fromDataBase(records.single);
    }
  }

  static saveUserPreferences(Preferences pref) async {
    await Supabase.instance.client.from(kPreferencesKey).update(
      {
        'trainerNames': pref.trainerNames,
        'revealUncaught': pref.revealUncaught
      },
    ).eq(
      'userIdentity',
      loggedUserId,
    );
  }

  static Future<List<Item>> getItemCollection(String table) async {
    var records = await Supabase.instance.client
        .from(table)
        .select()
        .match({'userIdentity': loggedUserId});

    if (records.isEmpty) {
      return List<Item>.empty(growable: true);
    } else {
      return List<Item>.from(
          (records.single['collection']).map((model) => Item.fromJson(model)));
    }
  }

  static saveCollection(String table, List<Item> items) async {
    await Supabase.instance.client.from(table).upsert(
      {'collection': items, 'userIdentity': loggedUserId},
    );
  }

  static Future<List<Tracker>> getTrackers() async {
    var records = await Supabase.instance.client
        .from(kTrackersKey)
        .select()
        .match({'userIdentity': loggedUserId});

    if (records.isEmpty) {
      return List<Tracker>.empty(growable: true);
    } else {
      return List<Tracker>.from(
          records.map((model) => Tracker.fromDatabase(model)));
    }
  }

  static getTracker(String ref) async {
    var record = await Supabase.instance.client
        .from(kTrackersKey)
        .select()
        .match({'userIdentity': loggedUserId, 'ref': ref}).single();

    return Tracker.fromDatabase(record);
  }

  static saveTracker(Tracker tracker) async {
    var records = await Supabase.instance.client
        .from(kTrackersKey)
        .select()
        .match({'userIdentity': loggedUserId, 'ref': tracker.ref});

    if (records.isEmpty) {
      await Supabase.instance.client.from(kTrackersKey).insert(
        {
          'userIdentity': loggedUserId,
          'name': tracker.name,
          'ref': tracker.ref,
          'game': tracker.game,
          'dex': tracker.dex,
          'type': tracker.type,
          'pokemons': tracker.pokemons,
        },
      ).eq('ref', tracker.ref);
    } else {
      await Supabase.instance.client.from(kTrackersKey).update(
        {
          'userIdentity': loggedUserId,
          'name': tracker.name,
          'ref': tracker.ref,
          'game': tracker.game,
          'dex': tracker.dex,
          'type': tracker.type,
          'pokemons': tracker.pokemons,
        },
      ).eq('ref', tracker.ref);
    }
  }

  static removeTracker(String ref) async {
    await Supabase.instance.client
        .from(kTrackersKey)
        .delete()
        .eq('ref', ref)
        .match({'userIdentity': loggedUserId});
  }
}
