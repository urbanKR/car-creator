import "dart:ui";
import "dart:io";

class Car {
  String type;
  int? soundId;
  Color bodyColor;
  Color glassColor;
  Color grillColor;
  String? name;
  File? realisticCar;

  Car(
      {required this.type,
      this.soundId,
      this.bodyColor = const Color(0xFF020202),
      this.glassColor = const Color(0xFF99f8ff),
      this.grillColor = const Color(0xFFfcfcfc),
      this.name,
      this.realisticCar});
}
