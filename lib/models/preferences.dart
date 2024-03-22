import 'package:oaks_legacy/database_manager.dart';

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

  save() => DatabaseManager.saveUserPreferences(this);
}
