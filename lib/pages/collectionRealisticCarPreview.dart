// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CollectionRealisticCarPreview extends StatefulWidget {
  const CollectionRealisticCarPreview({Key? key}) : super(key: key);

  @override
  _CollectionRealisticCarPreviewState createState() =>
      _CollectionRealisticCarPreviewState();
}

class _CollectionRealisticCarPreviewState
    extends State<CollectionRealisticCarPreview> {
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
                        //Realistic Car Preview Items
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Car1',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Concept',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          //Realistic Car image
                          SizedBox(
                            width: 330,
                            height: 330,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(25.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/realistic_car_concept_sample.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
