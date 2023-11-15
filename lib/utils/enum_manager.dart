import 'package:oaks_legacy/models/enums.dart';

extension CollectionDisplayTypeExtension on CollectionDisplayType {
  String text() {
    switch (this) {
      case CollectionDisplayType.groupByCurrentGame:
        return "(By Current Game)";
      case CollectionDisplayType.groupByOriginalGame:
        return "(By Origin Game)";
      case CollectionDisplayType.groupByPokemon:
        return "(By Pokemon)";
      default:
        return "";
    }
  }
}
