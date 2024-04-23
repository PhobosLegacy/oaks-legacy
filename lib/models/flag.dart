class Flags {
  bool underMaintenance;
  bool screenshot;

  Flags({required this.underMaintenance, required this.screenshot});

  factory Flags.fromDataBase(Map<String, dynamic> record) {
    return Flags(
      underMaintenance: record['underMaintenance'],
      screenshot: record['screenshot'],
    );
  }
}
