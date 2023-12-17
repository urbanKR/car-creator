import 'package:carcreator/pages/collectionCarPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
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
                        //Collection
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Collection',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          //Collection items
                          SizedBox(
                            height: 440,
                            child: ListView.builder(
                              itemCount: carArray.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CollectionCarPreview(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          carArray[index],
                                          width: 130,
                                          height: 120,
                                        ),
                                        const SizedBox(width: 40),
                                        Column(
                                          children: [
                                            Text(
                                              'Car ${index + 1}',
                                              style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text(
                                              'Creation Date',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text(
                                              '01.01.2024',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
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
