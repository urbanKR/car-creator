import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/models/Car.dart';
import 'package:carcreator/models/svg_class.dart';
import "dart:ui";

void main() {
  test('correctness of Car object creation', () {
    Car testCar = Car(
        id: 1, type: 'assets/graphics/Car1.svg', soundId: 3, name: 'testCar');
    expect(testCar.id, equals(1));
    expect(testCar.type, equals('assets/graphics/Car1.svg'));
    expect(testCar.soundId, equals(3));
    expect(testCar.bodyColor, equals(Color(0xFF020202)));
    expect(testCar.glassColor, equals(Color(0xFF99f8ff)));
    expect(testCar.grillColor, equals(Color(0xFFfcfcfc)));
    expect(testCar.name, equals('testCar'));
  });

  test('correctness of Car copy method', () {
    Car testCar = Car(
        id: 1, type: 'assets/graphics/Car1.svg', soundId: 3, name: 'testCar');
    Car copiedCar = testCar.copy(
        id: 2, type: 'assets/graphics/Car2.svg', name: 'copiedCar');

    expect(copiedCar.id, equals(2));
    expect(copiedCar.type, equals('assets/graphics/Car2.svg'));
    expect(copiedCar.soundId, equals(3));
    expect(copiedCar.bodyColor, equals(const Color(0xFF020202)));
    expect(copiedCar.glassColor, equals(const Color(0xFF99f8ff)));
    expect(copiedCar.grillColor, equals(const Color(0xFFfcfcfc)));
    expect(copiedCar.name, equals('copiedCar'));
  });

  test('correctness of Svg_class colorToHex method', () {
    String colorString_1 = SvgClass.colorToHex(const Color(0xFF020202));
    String colorString_2 = SvgClass.colorToHex(const Color(0xFF8CCCB5));
    String colorString_3 = SvgClass.colorToHex(const Color(0xFFA3E229));

    expect(colorString_1, equals('#020202'));
    expect(colorString_2, equals('#8cccb5'));
    expect(colorString_3, equals('#a3e229'));
  });

  test('correctness of SvgClass loadSvgString method', () {
    Future<String> svgString =
        SvgClass.loadSvgString('assets/graphics/Car4.svg');
    expect(svgString.toString().contains('sodipodi:docname="Car4.svg"'),
        equals(true));
  });
}
