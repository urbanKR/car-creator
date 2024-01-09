import "dart:ui";
import "dart:io";
import 'package:carcreator/models/svg_class.dart';
import "package:flutter/cupertino.dart";

const String tableCars = 'cars';

class CarFields {
  static const List<String> values = [
    id,
    type,
    soundId,
    bodyColor,
    glassColor,
    grillColor,
    name,
    realisticCar
  ];

  static const String id = '_id';
  static const String type = 'type';
  static const String soundId = 'soundId';
  static const String bodyColor = 'bodyColor';
  static const String glassColor = 'glassColor';
  static const String grillColor = 'grillColor';
  static const String name = 'name';
  static const String realisticCar = 'realisticCar';
}

class Car {
  int? id;
  String type;
  int? soundId;
  Color bodyColor;
  Color glassColor;
  Color grillColor;
  String? name;
  File? realisticCar;

  static Color defaultBodyColor = const Color(0xFF020202);
  static Color defaultGlassColor = const Color(0xFF99f8ff);
  static Color defaultGrillColor = const Color(0xFFfcfcfc);

  Car({
    this.id,
    required this.type,
    this.soundId,
    this.bodyColor = const Color(0xFF020202),
    this.glassColor = const Color(0xFF99f8ff),
    this.grillColor = const Color(0xFFfcfcfc),
    this.name,
    this.realisticCar,
  });

  Car copy({
    int? id,
    required String type,
    int? soundId,
    Color? bodyColor,
    Color? glassColor,
    Color? grillColor,
    String? name,
    File? realisticCar,
  }) =>
      Car(
        id: id ?? this.id,
        type: type,
        soundId: soundId ?? this.soundId,
        bodyColor: bodyColor ?? this.bodyColor,
        glassColor: glassColor ?? this.glassColor,
        grillColor: grillColor ?? this.grillColor,
        name: name ?? this.name,
        realisticCar: realisticCar ?? this.realisticCar,
      );

  Future<String> toStringCode() async {
    String svgCode = await SvgClass.loadSvgString(this.type);
    svgCode = svgCode.replaceAll(SvgClass.colorToHex(Car.defaultGrillColor),
        SvgClass.colorToHex(grillColor));
    svgCode = svgCode.replaceAll(SvgClass.colorToHex(Car.defaultBodyColor),
        SvgClass.colorToHex(bodyColor));
    svgCode = svgCode.replaceAll(SvgClass.colorToHex(Car.defaultGlassColor),
        SvgClass.colorToHex(glassColor));
    return svgCode;
  }

  static Car fromJson(Map<String, Object?> json) => Car(
      id: json[CarFields.id] as int?,
      type: json[CarFields.type] as String,
      soundId: json[CarFields.soundId] as int,
      bodyColor:
          Color(int.parse(json[CarFields.bodyColor] as String, radix: 16)),
      glassColor:
          Color(int.parse(json[CarFields.glassColor] as String, radix: 16)),
      grillColor:
          Color(int.parse(json[CarFields.grillColor] as String, radix: 16)),
      name: json[CarFields.name] as String,
      realisticCar: File(json[CarFields.realisticCar] as String));

  Map<String, Object?> toJson() => {
        CarFields.id: id,
        CarFields.type: type,
        CarFields.soundId: soundId,
        CarFields.bodyColor: bodyColor?.value.toRadixString(16),
        CarFields.glassColor: glassColor?.value.toRadixString(16),
        CarFields.grillColor: grillColor?.value.toRadixString(16),
        CarFields.name: name,
        CarFields.realisticCar: realisticCar?.path,
      };
}
