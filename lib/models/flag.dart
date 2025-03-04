class Flags {
  bool underMaintenance;
  bool screenshot;
  bool displayNews;
  bool displayContactUs;
  bool displayDonate;
  bool displayExport;
  bool displayImport;
  bool displayCustomTracker;

  Flags({
    required this.underMaintenance,
    required this.screenshot,
    required this.displayNews,
    required this.displayContactUs,
    required this.displayDonate,
    required this.displayExport,
    required this.displayImport,
    required this.displayCustomTracker,
  });

  factory Flags.fromDataBase(Map<String, dynamic> record) {
    return Flags(
      underMaintenance: record['underMaintenance'],
      screenshot: record['screenshot'],
      displayNews: record['displayNews'],
      displayContactUs: record['displayContactUs'],
      displayDonate: record['displayDonate'],
      displayExport: record['displayExport'],
      displayImport: record['displayImport'],
      displayCustomTracker: record['displayCustomTracker'],
    );
  }
}
