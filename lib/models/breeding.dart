class Breeding {
  Breeding({required this.groups, required this.cycles});

  final List<dynamic> groups;
  final String cycles;

  Breeding.fromJson(Map<String, dynamic> json)
      : groups = json['groups'],
        cycles = json['cycles'];

  Map<String, dynamic> toJson() {
    return {
      'groups': groups,
      'cycles': cycles,
    };
  }

  getSteps() {
    switch (cycles) {
      case "5":
        return "(1,029-1,285 steps)";
      case "10":
        return "(2,314-2,570 steps)";
      case "15":
        return "(3,599-3,855 steps)";
      case "20":
        return "(4,884-5,140 steps)";
      case "25":
        return "(6,169-6,425 steps)";
      case "30":
        return "(7,454-7,710 steps)";
      case "35":
        return "(8,739-8,995 steps)";
      case "40":
        return "(10,024-10,280 steps)";
      case "50":
        return "(12,594–12,850 steps)";
      case "80":
        return "(20,304-20,560 steps)";
      case "120":
        return "(30,584-30,840 steps)";
    }
    return "????";
  }
}
