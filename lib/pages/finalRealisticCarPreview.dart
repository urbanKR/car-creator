import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:carcreator/models/Car.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../database_helper.dart';
import 'home.dart';

class FinalRealisticCarPreview extends StatefulWidget {
  final Uint8List image;
  final Car ourCar;

  const FinalRealisticCarPreview({Key? key, required this.ourCar, required this.image}) : super(key: key);

  @override
  FinalRealisticCarPreviewState createState() => FinalRealisticCarPreviewState();
}

class FinalRealisticCarPreviewState extends State<FinalRealisticCarPreview> {
  late Car ourCar;
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    ourCar = widget.ourCar;
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<File> convertUint8ListToFile(Uint8List uint8List, String fileName) async {
    Directory tempDir = await getTemporaryDirectory();

    File tempFile = File('${tempDir.path}/$fileName');

    await tempFile.writeAsBytes(uint8List);

    return tempFile;
  }

  Future<void> _onSubmitButtonPressed(BuildContext context) async {
    String inputText = _textFieldController.text;

    ourCar.name = inputText;
    String fileName = '$inputText.png';
    File convertedFile = await convertUint8ListToFile(widget.image, fileName);
    ourCar.realisticCar = convertedFile;

    await CarsDatabase.instance.create(ourCar);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  const SizedBox(height: 10),
                  const Text(
                    'Real Concept',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'of your car',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.memory(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _onSubmitButtonPressed(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Save car',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
      child: Container(
        width: screenWidth,
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
                  width: screenWidth / 15,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double circleSize = screenWidth * 0.65;

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
    double screenWidth = MediaQuery.of(context).size.width;
    double circleSize = screenWidth * 0.65;

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
