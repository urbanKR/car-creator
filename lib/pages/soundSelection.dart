import 'package:flutter/material.dart';
import 'package:carcreator/pages/carColorSelection.dart';
import 'package:carcreator/models/Car.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundSelection extends StatefulWidget {
  final Car ourCar;

  const SoundSelection({Key? key, required this.ourCar}) : super(key: key);

  @override
  SoundSelectionState createState() => SoundSelectionState();
}

class SoundSelectionState extends State<SoundSelection> {
  int selectedButtonIndex = -1;
  late Car ourCar;

  final audioPlayer = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  void initState() {
    super.initState();
    ourCar = widget.ourCar; // Initialize ourCar with the passed Car object
  }

  double calculateButtonSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 2 - 12.0;
  }

  double calculateChessboardCellSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 15;
  }

  double calculateCircleSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.65;
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
            bottom: MediaQuery.of(context).size.height * 0.19,
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
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      final player = AudioPlayer();
                      if (index == 0) {
                        player.play(AssetSource('sounds/carSound1.mp3'));
                      }
                      if (index == 1) {
                        player.play(AssetSource('sounds/carSound2.wav'));
                      }
                      if (index == 2) {
                        player.play(AssetSource('sounds/carSound3.wav'));
                      }
                      if (index == 3) {
                        player.play(AssetSource('sounds/carSound4.mp3'));
                      }
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
          _buildChessboard(context),
          _buildLeftCircleWidget(context),
          _buildRightCircleWidget(context),
          _buildHeader(context),
          _buildArrowBackButton(context),
        ],
      ),
      floatingActionButton: _buildNextButton(context, selectedButtonIndex),
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
              'sound',
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


  Widget _buildNextButton(BuildContext context, int selectedButtonIndex) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 110.0, left: 20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: selectedButtonIndex != -1
              ? () {
            ourCar.soundId = selectedButtonIndex;
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CarColorSelection(ourCar: ourCar),
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
