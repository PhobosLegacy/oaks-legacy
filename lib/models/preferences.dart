import 'dart:convert';
import 'package:oaks_legacy/file_manager.dart';

class Preferences {
  bool revealUncaught;
  List<String> trainerNames = [];

  Preferences({required this.revealUncaught, required this.trainerNames});

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
        revealUncaught: json['revealUncaught'],
        trainerNames: json['trainerNames'] != null
            ? List<String>.from(json['trainerNames'].map((model) => (model)))
            : []);
  }

  Map<String, dynamic> toJson() {
    return {
      'revealUncaught': revealUncaught,
      'trainerNames': trainerNames.map((e) => e).toList()
    };
  }

  save() => FileManager.save('preferences', jsonEncode(this));
}
