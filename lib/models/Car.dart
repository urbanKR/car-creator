import "dart:ui";
import "dart:io";

class Car {
  int? bodyTypeId;
  String? soundId;
  Color? bodyColor;
  Color? glassColor;
  Color? grillColor;
  String? name;
  File? realisticCar;

  Car(
      {this.bodyTypeId,
      this.soundId,
      this.bodyColor,
      this.glassColor,
      this.grillColor,
      this.name,
      this.realisticCar});
}
