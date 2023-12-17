import 'package:flutter/material.dart';
import 'package:carcreator/pages/carColorSelection.dart';
import 'package:carcreator/models/Car.dart';

class SoundSelection extends StatefulWidget {
  final Car ourCar;
  const SoundSelection({Key? key, required this.ourCar}) : super(key: key);

  @override
  SoundSelectionState createState() => SoundSelectionState();
}

class SoundSelectionState extends State<SoundSelection> {
  int selectedButtonIndex = -1;
  late Car ourCar;

  @override
  void initState() {
    super.initState();
    ourCar = widget.ourCar; // Initialize ourCar with the passed Car object
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = const Color(0xFF700B0B);
    Color unselectedColorEven = Colors.red;
    Color unselectedColorOdd = Colors.black;
    Color selectedSpeakerColor = Colors.yellow;
    Color unselectedSpeakerColorEven = Colors.black;
    Color unselectedSpeakerColorOdd = Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 160,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
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
                            : index % 4 == 0 || index % 4 == 3
                                ? unselectedColorEven
                                : unselectedColorOdd,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(
                        Icons.volume_up,
                        size: 60,
                        color: selectedButtonIndex == index
                            ? selectedSpeakerColor
                            : index % 4 == 0 || index % 4 == 3
                                ? unselectedSpeakerColorEven
                                : unselectedSpeakerColorOdd,
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
                    'sound',
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
          margin: const EdgeInsets.only(bottom: 110.0, left: 20),
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            onPressed: selectedButtonIndex != -1
                ? () {
                    ourCar.soundId = selectedButtonIndex;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CarColorSelection(), // Replace SoundSelection with your actual page name
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
      ),
    );
  }
}
