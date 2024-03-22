import 'dart:convert';

import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/models/flag.dart';
import 'package:oaks_legacy/models/preferences.dart';
import 'package:oaks_legacy/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseManager {
  static late UserData user;

  static initSupabase() async {
    await Supabase.initialize(
      url: kSupabaseUrl,
      anonKey: kSupabaseKey,
    );
  }

  //TEMP Retrieve user info before we set a proper auth
  static setUser() async {
    var userRecord = await Supabase.instance.client
        .from('users')
        .select()
        .match({'email': 'admin', 'password': 'admin'}).single();

    user = UserData(
        user: userRecord['email'],
        pass: userRecord['password'],
        identity: userRecord['userIdentity']);
  }

  static Future<Flags> getSystemFlags() async {
    var record =
        await Supabase.instance.client.from(kFlagsKey).select().single();

    return Flags.fromDataBase(record);
  }

  static Future<Preferences> getUserPreferences() async {
    var records = await Supabase.instance.client
        .from(kPreferencesKey)
        .select()
        .match({'userIdentity': user.identity});

    if (records.isEmpty) {
      var newUserPreferences = await Supabase.instance.client
          .from(kPreferencesKey)
          .insert({
        'userIdentity': user.identity,
        'trainerNames': List<String>.empty()
      }).select();

      return Preferences.fromDataBase(newUserPreferences.single);
    } else {
      return Preferences.fromDataBase(records.single);
    }
  }

  static get(String table) async {
    var records = await Supabase.instance.client
        .from(table)
        .select()
        .match({'user_identity': user.identity}).single();

    return records;
  }

  static saveUserPreferences(Preferences pref) async {
    await Supabase.instance.client.from(kPreferencesKey).update(
      {
        'trainerNames': pref.trainerNames,
        'revealUncaught': pref.revealUncaught
      },
    ).eq(
      'userIdentity',
      user.identity,
    );
  }
}



    // final supabase = Supabase.instance.client;
    // var signUp =
    //     await supabase.auth.signUp(email: 'admin@admin.com', password: 'admin');

    // var test = await supabase.auth
    //     .signInWithPassword(email: "admin", password: "admin");