import 'dart:ui';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/models/Car.dart';

void main() {
  group('Car Model', () {
    test('toJson converts Car object to JSON correctly', () {
      final car = Car(
        id: 1,
        type: 'SUV',
        soundId: 101,
        bodyColor: Color(0xFF020202),
        glassColor: Color(0xFF99f8ff),
        grillColor: Color(0xFFfcfcfc),
        name: 'My Car',
        realisticCar: File('path/to/file'),
      );

      final json = car.toJson();
      print('JSON: $json');

      expect(json['_id'], 1);
      expect(json['type'], 'SUV');
      expect(json['soundId'], 101);
      expect(json['bodyColor'], 'ff020202');
      expect(json['glassColor'], 'ff99f8ff');
      expect(json['grillColor'], 'fffcfcfc');
      expect(json['name'], 'My Car');
      expect(json['realisticCar'], 'path/to/file');
    });

    test('fromJson converts JSON to Car object correctly', () {
      final json = {
        '_id': 1,
        'type': 'SUV',
        'soundId': 101,
        'bodyColor': 'ff020202',
        'glassColor': 'ff99f8ff',
        'grillColor': 'fffcfcfc',
        'name': 'My Car',
        'realisticCar': 'path/to/file',
      };

      final car = Car.fromJson(json);
      print('Car: ${car.id}, ${car.type}, ${car.soundId}, ${car.bodyColor}, ${car.glassColor}, ${car.grillColor}, ${car.name}, ${car.realisticCar?.path}'); // Debugging statement

      expect(car.id, 1);
      expect(car.type, 'SUV');
      expect(car.soundId, 101);
      expect(car.bodyColor, Color(0xFF020202));
      expect(car.glassColor, Color(0xFF99f8ff));
      expect(car.grillColor, Color(0xFFfcfcfc));
      expect(car.name, 'My Car');
      expect(car.realisticCar?.path, 'path/to/file');
    });
  });
}