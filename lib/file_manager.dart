// import 'package:shared_preferences/shared_preferences.dart';

// class FileManager {
//   static late SharedPreferences preferences;

//   static loadPreferences() async =>
//       preferences = await SharedPreferences.getInstance();

//   static removeAllKeys() {
//     for (var key in preferences.getKeys()) {
//       preferences.remove(key);
//     }
//   }

//   static bool exists(String name) {
//     bool ret = preferences.containsKey(name);
//     // print("Key with name $name: $ret");
//     return ret;
//   }

//   static getAllByPrefix(String prefix) {
//     return preferences
//         .getKeys()
//         .where((element) => element.startsWith(prefix))
//         .toList();
//   }

//   static String get(String name) {
//     return (exists(name)) ? preferences.getString(name)! : "";
//   }

//   static save(String name, String value) => preferences.setString(name, value);

//   static delete(String name) => preferences.remove(name);
// }
