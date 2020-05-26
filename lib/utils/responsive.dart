import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width, height, inch;

  Responsive({
    @required this.width,
    @required this.height,
    @required this.inch,
  });

  factory Responsive.of(BuildContext context) {
    final dataSize = MediaQuery.of(context).size;
    final inch = math.sqrt(math.pow(dataSize.width, 2) + math.pow(dataSize.height, 2));

    return Responsive(width: dataSize.width, height: dataSize.height, inch: inch);
  }

  double withPercent(double percent) => this.width * percent / 100;
  double heightPercent(double percent) => this.height * percent / 100;
  double inchPercent(double percent) => this.inch * percent / 100;
}
