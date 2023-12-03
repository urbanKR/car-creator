import 'package:flutter/material.dart';
import 'package:carcreator/pages/carTypeSelection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Chessboard pattern
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
          // Other widgets
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
              translation: const Offset(0.0, 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.directions_car,
                    size: 100,
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'CarCreator',
                    style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'RacingSansOne',
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CarTypeSelection(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: const Text(
                        'Create a car',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: const Text(
                        'Collection',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
