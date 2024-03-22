class Flags {
  bool underMaintenance;

  Flags({required this.underMaintenance});

  factory Flags.fromDataBase(Map<String, dynamic> record) {
    return Flags(underMaintenance: record['underMaintenance']);
  }
}
