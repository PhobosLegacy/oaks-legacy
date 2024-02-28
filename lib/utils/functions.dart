import 'package:oaks_legacy/constants.dart';

double getButtonWidth(double width, List<double> widths) {
  for (int i = 0; i < kBreakpoints.length; i++) {
    if (width < kBreakpoints[i]) {
      return widths[i];
    }
  }

  return widths.last;
}
