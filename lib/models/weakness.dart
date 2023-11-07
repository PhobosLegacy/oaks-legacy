class Weakness {
  Weakness(
      {required this.quarter,
      required this.half,
      required this.none,
      required this.double,
      required this.quadruple});

  final List<dynamic> quarter;
  final List<dynamic> half;
  final List<dynamic> none;
  final List<dynamic> double;
  final List<dynamic> quadruple;

  Weakness.fromJson(Map<String, dynamic> json)
      : quarter = json['quarter'],
        half = json['half'],
        none = json['none'],
        double = json['double'],
        quadruple = json['quadruple'];

  Map<String, dynamic> toJson() {
    return {
      'quarter': quarter,
      'half': half,
      'none': none,
      'double': double,
      'quadruple': quadruple,
    };
  }
}
