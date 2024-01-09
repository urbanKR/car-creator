import 'package:audioplayers/audioplayers.dart';
import 'package:carcreator/api/aiImageApi.dart';
import 'package:flutter/material.dart';
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
  String textPrompt = "red car on the highway";
  bool isLoading = false;
  String carName = "";
  Color defaultBodyColor = const Color(0xFF020202);
  Color defaultGlassColor = const Color(0xFF99f8ff);
  Color defaultGrillColor = const Color(0xFFfcfcfc);
  late Car ourCar;
  late String svgCode = '';

  @override
  void initState() {
    super.initState();
    ourCar = widget.ourCar; // Initialize ourCar with the passed Car object

    loadSvg();
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
                        //Car Preview Items
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
                            height: 50,
                          ),
                          //Car svg
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
                            height: 20,
                          ),
                          //btn
                          SizedBox(
                            width: 0.9 * MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                ourCar.name = carName;
                                convertTextToImage(textPrompt, ourCar, context);
                                isLoading = true;
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.black)
                                  : const Text(
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
