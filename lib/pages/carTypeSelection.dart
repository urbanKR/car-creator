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

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Color.fromARGB(255, 184, 6, 6);
    Color unselectedColor = Colors.red;

    return Scaffold(
      body: Stack(
        children: [
          _buildCarButtons(context, selectedColor, unselectedColor),
          _buildChessboard(context),
          _buildLeftCircleWidget(context),
          _buildRightCircleWidget(context),
          _buildHeader(context),
          _buildArrowBackButton(context)
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
              'Choose the car',
              style: TextStyle(
                fontSize: 45,
              ),
            ),
            Text(
              'type',
              style: TextStyle(
                fontSize: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarButtons(
      BuildContext context, Color selectedColor, Color unselectedColor) {
    return Positioned(
      bottom: 160,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 450,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 4,
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
                  width: 30,
                  height: 30,
                ),
              ),
            );
          },
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

  Widget _buildNextButton(
      BuildContext context, int selectedButtonIndex, List<String> carImages) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 110.0, left: 20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: selectedButtonIndex != -1
              ? () {
                  Car ourCar = Car(type: carImages[selectedButtonIndex]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SoundSelection(ourCar: ourCar),
                    ),
                  );
                }
              : null,
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
    );
  }
}
