import 'package:carcreator/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:carcreator/pages/finalCarPreview.dart';
import 'package:carcreator/models/Car.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GrillColorSelection extends StatefulWidget {
  final Car ourCar;
  const GrillColorSelection({Key? key, required this.ourCar}) : super(key: key);

  @override
  GrillColorSelectionState createState() => GrillColorSelectionState();
}

class GrillColorSelectionState extends State<GrillColorSelection> {
  Color selectedColor = Colors.grey;
  late Car ourCar;

  @override
  void initState() {
    super.initState();
    ourCar = widget.ourCar; // Initialize ourCar with the passed Car object
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: List.generate(
                  4,
                  (i) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      15,
                      (j) => Container(
                        width: MediaQuery.of(context).size.width / 15,
                        height: 25,
                        decoration: BoxDecoration(
                          color: (i % 2 == 0)
                              ? (j % 2 == 0)
                                  ? Colors.black
                                  : Colors.white
                              : (j % 2 == 0)
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            left: 20,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.4),
              ),
            ),
          ),
          Positioned(
            top: -10,
            left: -140,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.4),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: Offset(0.0, -0.32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose the',
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    'grill color',
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: const Offset(0.0, 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //Car Preview Items
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        ourCar.type,
                        colorFilter:
                            ColorFilter.mode(selectedColor, BlendMode.srcIn),
                        key: const ValueKey('groupGrill'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ColorPicker(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 110.0, left: 20),
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            onPressed: () {
              ourCar.grillColor = selectedColor;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FinalCarPreview(ourCar: ourCar),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i in grillColors.entries)
          GestureDetector(
              onTap: () {
                setState(() {
                  grillColors.updateAll((key, value) {
                    if (key != i.key) {
                      return value = false;
                    }
                    return value = true;
                  });
                });
              },
              child: ColorPickerItem(color: i.key, isChecked: i.value)),
      ],
    );
  }
}

class ColorPickerItem extends StatelessWidget {
  const ColorPickerItem(
      {super.key, required this.color, required this.isChecked});

  final Color color;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 29,
      child: CircleAvatar(
        backgroundColor: color,
        radius: 26,
        child: isChecked
            ? const Icon(
                Icons.check,
                size: 35,
              )
            : null,
      ),
    );
  }
}
