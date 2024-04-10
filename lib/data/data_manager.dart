import 'dart:convert';
import 'package:oaks_legacy/components/pkm_login.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/data/database_manager.dart';
import 'package:oaks_legacy/data/file_manager.dart';
import 'package:oaks_legacy/models/item.dart';
import 'package:oaks_legacy/models/preferences.dart';
import 'package:oaks_legacy/models/tracker.dart';

class DataManager {
  static start() async {
    await FileManager.loadPreferences();
    await DatabaseManager.initSupabase();
  }

  static setSystemFlags() async =>
      kFlags = await DatabaseManager.getSystemFlags();

  static void setUserPreferences() async {
    if (isUserLogged) {
      kPreferences = await DatabaseManager.getUserPreferences();
    } else {
      if (FileManager.exists(kPreferencesKey)) {
        kPreferences = Preferences.fromDataBase(
            jsonDecode(FileManager.get(kPreferencesKey)));
      } else {
        kPreferences = Preferences(revealUncaught: false, trainerNames: []);
      }
    }
  }

  static void saveUserPreferences(Preferences preferences) async {
    if (isUserLogged) {
      await DatabaseManager.saveUserPreferences(preferences);
    } else {
      FileManager.save(kPreferencesKey, jsonEncode(preferences.toJson()));
    }
  }

  static Future<List<Item>> getItemCollection(String table) async {
    if (isUserLogged) {
      return await DatabaseManager.getItemCollection(table);
    } else {
      String content = FileManager.get(table);
      if (content.isEmpty) return List<Item>.empty(growable: true);
      return List<Item>.from(
          (jsonDecode(content)).map((model) => Item.fromJson(model)));
    }
  }

  static saveCollection(String table, List<Item> items) async {
    if (isUserLogged) {
      DatabaseManager.saveCollection(table, items);
    } else {
      FileManager.save(table, jsonEncode(items));
    }
  }

  static Future<List<Tracker>> getTrackers() async {
    if (isUserLogged) {
      return DatabaseManager.getTrackers();
    } else {
      List<Tracker> localTrackers = List<Tracker>.empty(growable: true);
      var keys = FileManager.getAllByPrefix(kTrackerPrefix);
      for (var key in keys) {
        Tracker tracker =
            Tracker.fromDatabase(jsonDecode(FileManager.get(key)));
        localTrackers.add(tracker);
      }
      return localTrackers;
    }
  }

  static getTracker(String ref) async {
    if (isUserLogged) {
      return DatabaseManager.getTracker(ref);
    } else {
      return Tracker.fromJson(jsonDecode(FileManager.get(ref)));
    }
  }

  static saveTracker(Tracker tracker) async {
    if (isUserLogged) {
      await DatabaseManager.saveTracker(tracker);
    } else {
      FileManager.save(tracker.ref, jsonEncode(tracker));
    }
  }

  static removeTracker(String ref) async {
    if (isUserLogged) {
      await DatabaseManager.removeTracker(ref);
    } else {
      FileManager.delete(ref);
    }
  }
}
