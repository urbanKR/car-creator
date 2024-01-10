import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class SvgClass {
  static Future<String> loadSvgString(String svgPath) async {
    final String svgString = await rootBundle.loadString(svgPath);
    return svgString;
  }

  static String colorToHex(Color color) {
    return '#' +
        color.red.toRadixString(16).padLeft(2, '0') +
        color.green.toRadixString(16).padLeft(2, '0') +
        color.blue.toRadixString(16).padLeft(2, '0');
  }
}
