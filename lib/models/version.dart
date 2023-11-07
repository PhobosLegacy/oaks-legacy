class Data {
  int app;
  int dex;
  int tracker;
  int collection;
  int lookingFor;
  int forTrade;

  Data(
      {required this.app,
      required this.dex,
      required this.tracker,
      required this.collection,
      required this.lookingFor,
      required this.forTrade});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      app: json['app'],
      dex: json['dex'],
      tracker: json['tracker'],
      collection: json['collection'],
      lookingFor: json['lookingFor'],
      forTrade: json['forTrade'],
    );
  }

  Map<String, int> toJson() {
    return {
      'app': app,
      'dex': dex,
      'tracker': tracker,
      'collection': collection,
      'lookingFor': lookingFor,
      'forTrade': forTrade,
    };
  }
}
