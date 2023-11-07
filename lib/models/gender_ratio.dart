class GenderRatio {
  GenderRatio(
      {required this.male, required this.female, required this.genderless});

  final String male;
  final String female;
  final String genderless;

  GenderRatio.fromJson(Map<String, dynamic> json)
      : male = json['male'],
        female = json['female'],
        genderless = json['genderless'];

  Map<String, dynamic> toJson() {
    return {
      'male': male,
      'female': female,
      'genderless': genderless,
    };
  }
}
