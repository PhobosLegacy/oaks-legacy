import 'package:oaks_legacy/data/data_manager.dart';

class Preferences {
  bool revealUncaught;
  List<String> trainerNames = [];

  Preferences({required this.revealUncaught, required this.trainerNames});

  factory Preferences.fromDataBase(Map<String, dynamic> record) {
    return Preferences(
      revealUncaught: record['revealUncaught'],
      trainerNames: List<String>.from(
        record['trainerNames'].map(
          (model) => (model),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'revealUncaught': revealUncaught,
      'trainerNames': trainerNames,
    };
  }

  save() => DataManager.saveUserPreferences(this);
}
