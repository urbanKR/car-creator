import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as picker;
import 'package:flutter_svg/svg.dart';
import '../models/Car.dart';
import '../models/svg_class.dart';
import 'finalCarPreview.dart';

class GrillColorSelection extends StatefulWidget {
  final Car ourCar;
  const GrillColorSelection({Key? key, required this.ourCar}) : super(key: key);

  @override
  GrillColorSelectionState createState() => GrillColorSelectionState();
}

class GrillColorSelectionState extends State<GrillColorSelection> {
  Color defaultBodyColor = const Color(0xFF020202);
  Color defaultGlassColor = const Color(0xFF99f8ff);
  Color previousColor = const Color(0xFFfcfcfc);
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
      svgCode = svgCode.replaceAll(SvgClass.colorToHex(defaultGlassColor),
          SvgClass.colorToHex(ourCar.glassColor));
      ourCar.grillColor = selectedColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
      body: Stack(
        children: [
          _buildChessboard(context),
          _buildLeftCircleWidget(context),
          _buildRightCircleWidget(context),
          _buildHeader(context),
          _buildArrowBackButton(context, buttonSize),
          Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: const Offset(0.0, 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // Car Preview Items
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.string(
                        svgCode, // Use the loaded SVG string here
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      _showColorPickerDialog(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Choose Color',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
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
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FinalCarPreview(ourCar: ourCar),
                  transitionsBuilder: (context, animation, secondaryAnimation,
                      child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 20,
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
    double circleSize = MediaQuery.of(context).size.width * 0.65;

    return Positioned(
      top: -circleSize * 0.5,
      left: circleSize * 0.1,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildRightCircleWidget(BuildContext context) {
    double circleSize = MediaQuery.of(context).size.width * 0.65;

    return Positioned(
      top: -10,
      left: -circleSize * 0.6,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.07;
    return Align(
      alignment: Alignment.center,
      child: FractionalTranslation(
        translation: const Offset(0.0, -0.32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose the',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            Text(
              'grill color',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArrowBackButton(BuildContext context, double buttonSize) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width * 0.05,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(buttonSize / 2),
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

  void _showColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color currentColor = ourCar.grillColor;
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: picker.ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  currentColor = color;
                });
              },
              enableAlpha: false,
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                loadSvg(previousColor, currentColor);
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
