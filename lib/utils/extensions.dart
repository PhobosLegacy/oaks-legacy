const romanNumerals = [
  'I', // 1
  'II', // 2
  'III', // 3
  'IV', // 4
  'V', // 5
  'VI', // 6
  'VII', // 7
  'VIII', // 8
  'IX' // 9
];

extension StringExtensions on int {
  String getRomanNumber() {
    return romanNumerals[this];
  }
}
