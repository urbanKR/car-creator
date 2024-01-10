import 'package:carcreator/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:carcreator/pages/grillColorSelection.dart';
import 'package:carcreator/models/Car.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carcreator/models/svg_class.dart';

class GlassColorSelection extends StatefulWidget {
  final Car ourCar;
  const GlassColorSelection({Key? key, required this.ourCar}) : super(key: key);

  @override
  GlassColorSelectionState createState() => GlassColorSelectionState();
}

class GlassColorSelectionState extends State<GlassColorSelection> {
  Color defaultBodyColor = const Color(0xFF020202);
  Color previousColor = const Color(0xFF99f8ff);
  late Car ourCar;
  late String svgCode = '';

  @override
  void initState() {
    super.initState();
    ourCar = widget.ourCar;
    loadSvg(previousColor, previousColor);
  }

  Future<void> loadSvg(Color previousColor, Color selectedColor) async {
    final String svgString = await SvgClass.loadSvgString(ourCar.type);
    setState(() {
      svgCode = svgString.replaceAll(SvgClass.colorToHex(previousColor),
          SvgClass.colorToHex(selectedColor));
      svgCode = svgCode.replaceAll(SvgClass.colorToHex(defaultBodyColor),
          SvgClass.colorToHex(ourCar.bodyColor));
      ourCar.glassColor = selectedColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildChessboard(context),
          _buildLeftCircleWidget(context),
          _buildRightCircleWidget(context),
          _buildHeader(context),
          _buildArrowBackButton(context),
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
                      child: SvgPicture.string(
                        svgCode, // Use the loaded SVG string here
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ColorPicker(onColorSelected: (Color selected) {
                    loadSvg(previousColor, selected);
                  }),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GrillColorSelection(ourCar: ourCar),
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

  Widget _buildChessboard(BuildContext context) {
    return Positioned(
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
    );
  }

  Widget _buildLeftCircleWidget(BuildContext context) {
    return Positioned(
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
    );
  }

  Widget _buildRightCircleWidget(BuildContext context) {
    return Positioned(
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
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const Align(
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
              'glass color',
              style: TextStyle(
                fontSize: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArrowBackButton(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Function(Color) onColorSelected;

  const ColorPicker({required this.onColorSelected, Key? key})
      : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i in carColors.entries)
          GestureDetector(
            onTap: () {
              setState(() {
                carColors.updateAll((key, value) {
                  if (key != i.key) {
                    return value = false;
                  }
                  widget.onColorSelected(i.key);
                  return value = true;
                });
              });
            },
            child: ColorPickerItem(color: i.key, isChecked: i.value),
          ),
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
