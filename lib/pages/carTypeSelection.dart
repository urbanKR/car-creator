import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carcreator/pages/soundSelection.dart';
import 'package:carcreator/models/Car.dart';

class CarTypeSelection extends StatefulWidget {
  const CarTypeSelection({Key? key}) : super(key: key);

  @override
  CarTypeSelectionState createState() => CarTypeSelectionState();
}

class CarTypeSelectionState extends State<CarTypeSelection> {
  final List<String> carImages = const [
    'assets/graphics/Car1.svg',
    'assets/graphics/Car2.svg',
    'assets/graphics/Car3.svg',
    'assets/graphics/Car4.svg',
  ];

  int selectedButtonIndex = -1;

  double calculateButtonSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 2 - 11.0;
  }

  double calculateChessboardCellSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 15;
  }

  double calculateCircleSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.65;
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = const Color.fromARGB(255, 184, 6, 6);
    Color unselectedColor = Colors.red;
    double fontSize = MediaQuery.of(context).size.width * 0.07;

    return Scaffold(
      body: Stack(
        children: [
          _buildCarButtons(context, selectedColor, unselectedColor),
          _buildChessboard(context),
          _buildLeftCircleWidget(context),
          _buildRightCircleWidget(context),
          _buildHeader(context, fontSize),
          _buildArrowBackButton(context),
        ],
      ),
      floatingActionButton:
      _buildNextButton(context, selectedButtonIndex, carImages),
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
                  width: calculateChessboardCellSize(context),
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
      top: -calculateCircleSize(context) * 0.5,
      left: calculateCircleSize(context) * 0.1,
      child: Container(
        width: calculateCircleSize(context),
        height: calculateCircleSize(context),
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
      left: -calculateCircleSize(context) * 0.6,
      child: Container(
        width: calculateCircleSize(context),
        height: calculateCircleSize(context),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double fontSize) {
    return Align(
      alignment: Alignment.center,
      child: FractionalTranslation(
        translation: const Offset(0.0, -0.32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose the car',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            Text(
              'type',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarButtons(
      BuildContext context, Color selectedColor, Color unselectedColor) {
    double buttonSize = calculateButtonSize(context);

    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.15,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 470,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: carImages.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedButtonIndex =
                  selectedButtonIndex == index ? -1 : index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: selectedButtonIndex == index
                      ? selectedColor
                      : unselectedColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SvgPicture.asset(
                  carImages[index],
                  width: buttonSize,
                  height: buttonSize,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildArrowBackButton(BuildContext context) {
    double buttonSize = MediaQuery.of(context).size.width * 0.1;

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

  Widget _buildNextButton(
      BuildContext context, int selectedButtonIndex, List<String> carImages) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    double buttonFontSize = MediaQuery.of(context).size.width * 0.06;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 110.0, left: 20),
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: selectedButtonIndex != -1
              ? () {
            Car ourCar = Car(type: carImages[selectedButtonIndex]);
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    SoundSelection(ourCar: ourCar),
                transitionsBuilder: (context, animation,
                    secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: buttonFontSize,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
