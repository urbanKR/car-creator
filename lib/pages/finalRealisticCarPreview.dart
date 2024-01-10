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
  const FinalRealisticCarPreview(
      {Key? key, required this.ourCar, required this.image})
      : super(key: key);

  @override
  FinalRealisticCarPreviewState createState() =>
      FinalRealisticCarPreviewState();

}

class FinalRealisticCarPreviewState extends State<FinalRealisticCarPreview> {
  File? realisticImage;
  late Car ourCar;
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    ourCar = widget.ourCar; // Initialize ourCar with the passed Car object
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }


  Future<File> convertUint8ListToFile(Uint8List uint8List, String fileName) async {
    // Create a temporary directory
    Directory tempDir = await getTemporaryDirectory();

    // Create a temporary file with a unique name
    File tempFile = File('${tempDir.path}/$fileName');

    // Write the bytes to the file
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
        builder: (context) => const HomePage(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
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
                  Align(
                    alignment: Alignment.center,
                    child: FractionalTranslation(
                      translation: const Offset(0.0, 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Real Concept',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'of your car',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 330,
                            height: 330,
                            child: Container(
                              width: 340,
                              height: 500,
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
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add the input text field
                  TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      hintText: 'Enter name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Add the button
                  ElevatedButton(
                    onPressed: () {
                      _onSubmitButtonPressed(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    child: const Text('Save car',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         _buildChessboard(context),
  //         _buildLeftCircleWidget(context),
  //         _buildRightCircleWidget(context),
  //         Align(
  //           alignment: Alignment.center,
  //           child: FractionalTranslation(
  //             translation: const Offset(0.0, 0.01),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: FractionalTranslation(
  //                     translation: const Offset(0.0, 0.01),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       //Realistic Car Preview Items
  //                       children: [
  //                         const SizedBox(
  //                           height: 5,
  //                         ),
  //                         const Text(
  //                           'Real Concept',
  //                           style: TextStyle(
  //                             fontSize: 50,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const Text(
  //                           'of your car',
  //                           style: TextStyle(
  //                             fontSize: 50,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 20,
  //                         ),
  //                         //Realistic Car image
  //                         SizedBox(
  //                           width: 330,
  //                           height: 330,
  //                           child: Container(
  //                             width: 340,
  //                             height: 500,
  //                             decoration: BoxDecoration(
  //                               color: Colors.red,
  //                               borderRadius: BorderRadius.circular(25),
  //                             ),
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(25),
  //                               child: Image.memory(
  //                                 widget.image,
  //                                 fit: BoxFit.cover,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 200,
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
}
