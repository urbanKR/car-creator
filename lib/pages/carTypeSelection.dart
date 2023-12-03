import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarTypeSelection extends StatefulWidget {
  const CarTypeSelection({Key? key}) : super(key: key);

  @override
  _CarTypeSelectionState createState() => _CarTypeSelectionState();
}

class _CarTypeSelectionState extends State<CarTypeSelection> {

  final List<String> carImages = const [
    'assets/graphics/Car1.svg',
    'assets/graphics/Car2.svg',
    'assets/graphics/Car3.svg',
    'assets/graphics/Car4.svg',
  ];

  int selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Color(0xFF700B0B);
    Color unselectedColor = Colors.red;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 160,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      padding: EdgeInsets.all(8.0),
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
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
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
                              ? (j % 2 == 0) ? Colors.black : Colors.white
                              : (j % 2 == 0) ? Colors.white : Colors.black,
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
          Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: const Offset(0.0, -0.28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Choose the car',
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  const Text(
                    'type',
                    style: TextStyle(
                      fontSize: 45,
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
          margin: EdgeInsets.only(bottom: 110.0, left: 20),
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            onPressed: selectedButtonIndex != -1
                ? () {
            }
                : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                )
            ),
          ),
        ),
      ),
    );
  }
}
