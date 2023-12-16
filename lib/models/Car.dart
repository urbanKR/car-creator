import "dart:ui";
import "dart:io";

class Car {
  String? type;
  String? soundId;
  Color? bodyColor;
  Color? glassColor;
  Color? grillColor;
  String? name;
  File? realisticCar;

  Car(
      {this.type,
      this.soundId,
      this.bodyColor,
      this.glassColor,
      this.grillColor,
      this.name,
      this.realisticCar});
}
