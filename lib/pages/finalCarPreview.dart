import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:carcreator/api/aiImageApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carcreator/models/Car.dart';
import 'package:carcreator/models/svg_class.dart';

class FinalCarPreview extends StatefulWidget {
  final Car ourCar;
  const FinalCarPreview({Key? key, required this.ourCar}) : super(key: key);

  @override
  FinalCarPreviewState createState() => FinalCarPreviewState();
}

class FinalCarPreviewState extends State<FinalCarPreview> {
  //test prompt
  late String textPrompt;
  bool isLoading = false;
  String carName = "";
  Color defaultBodyColor = const Color(0xFF020202);
  Color defaultGlassColor = const Color(0xFF99f8ff);
  Color defaultGrillColor = const Color(0xFFfcfcfc);
  late Car ourCar;
  late String svgCode = '';
  Timer? _timer;
  late double _progress;

  @override
  void initState() {
    super.initState();
    ourCar = widget.ourCar; // Initialize ourCar with the passed Car object
    textPrompt = createPrompt();
    loadSvg();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  String createPrompt() {
    late String typeConverted;
    String type = ourCar.type;
    String glass = ourCar.glassColor.toString();
    String body = ourCar.bodyColor.toString();
    String grill = ourCar.grillColor.toString();

    if (type == 'assets/graphics/Car1.svg') {
      typeConverted = 'sport';
    } else if (type == 'assets/graphics/Car2.svg') {
      typeConverted = 'jeep';
    } else if (type == 'assets/graphics/Car3.svg') {
      typeConverted = 'daily';
    } else if (type == 'assets/graphics/Car4.svg') {
      typeConverted = 'SUV';
    }

    String result =
        '$body $typeConverted car with $glass glass and $grill grill';
    return result;
  }

  Future<void> loadSvg() async {
    final String svgString = await SvgClass.loadSvgString(ourCar.type);
    setState(() {
      svgCode = svgString.replaceAll(SvgClass.colorToHex(defaultGrillColor),
          SvgClass.colorToHex(ourCar.grillColor));
      svgCode = svgCode.replaceAll(SvgClass.colorToHex(defaultBodyColor),
          SvgClass.colorToHex(ourCar.bodyColor));
      svgCode = svgCode.replaceAll(SvgClass.colorToHex(defaultGlassColor),
          SvgClass.colorToHex(ourCar.glassColor));
    });
    final player = AudioPlayer();
    if (ourCar.soundId == 0) {
      player.play(AssetSource('sounds/carSound1.mp3'));
    }
    if (ourCar.soundId == 1) {
      player.play(AssetSource('sounds/carSound2.wav'));
    }
    if (ourCar.soundId == 2) {
      player.play(AssetSource('sounds/carSound3.wav'));
    }
    if (ourCar.soundId == 3) {
      player.play(AssetSource('sounds/carSound4.mp3'));
    }
  }

  final List<String> carArray = const [
    //wrong size first??
    // 'assets/graphics/Car1.svg',
    'assets/graphics/Car2.svg',
    'assets/graphics/Car3.svg',
    'assets/graphics/Car4.svg',
    'assets/graphics/Car2.svg',
    'assets/graphics/Car3.svg',
    'assets/graphics/Car4.svg',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          _buildChessboard(context),
          _buildLeftCircleWidget(context),
          _buildRightCircleWidget(context),
          Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: const Offset(0.0, 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: FractionalTranslation(
                      translation: const Offset(0.0, 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Here is your car!',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Car svg
                          SizedBox(
                            width: screenWidth * 0.8,
                            height: screenWidth * 0.8,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.string(
                                svgCode, // Use the loaded SVG string here
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          // Button
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: ElevatedButton(
                              onPressed: () {
                                ourCar.name = carName;
                                convertTextToImage(textPrompt, ourCar, context);
                                isLoading = true;
                                setState(() {});
                                _progress = 0;
                                _timer?.cancel();
                                _timer = Timer.periodic(
                                    const Duration(milliseconds: 100),
                                    (Timer timer) {
                                  EasyLoading.showProgress(_progress,
                                      status:
                                          '${(_progress * 100).toStringAsFixed(0)}%');
                                  _progress += 0.003;
                                  if (_progress >= 1) {
                                    _timer?.cancel();
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'Show concept',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildArrowBackButton(context),
        ],
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
}
