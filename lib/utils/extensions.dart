import 'package:intl/intl.dart';

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

extension IntExtensions on int {
  String getRomanNumber() {
    return romanNumerals[this];
  }
}

extension StringExtensions on String {
  String formatDateTime() {
    return DateFormat('dd/MM/yyyy').format(
      DateTime.parse(this),
    );
  }
}
