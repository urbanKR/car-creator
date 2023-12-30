import 'package:carcreator/api/aiImageApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carcreator/models/Car.dart';

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
  late Car ourCar;

  @override
  void initState() {
    super.initState();
    ourCar = widget.ourCar; // Initialize ourCar with the passed Car object
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
          Positioned(
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
          ),
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
                              fontSize: 50,
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
                              child: SvgPicture.asset(ourCar.type),
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
                                  ? const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                          color: Colors.black))
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
        ],
      ),
    );
  }
}
