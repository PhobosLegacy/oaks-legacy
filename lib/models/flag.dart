class Flags {
  bool underMaintenance;
  bool screenshot;
  bool displayNews;
  bool displayContactUs;
  bool displayDonate;

  Flags({
    required this.underMaintenance,
    required this.screenshot,
    required this.displayNews,
    required this.displayContactUs,
    required this.displayDonate,
  });

  factory Flags.fromDataBase(Map<String, dynamic> record) {
    return Flags(
      underMaintenance: record['underMaintenance'],
      screenshot: record['screenshot'],
      displayNews: record['displayNews'],
      displayContactUs: record['displayContactUs'],
      displayDonate: record['displayDonate'],
    );
  }
}
