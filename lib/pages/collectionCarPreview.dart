import 'package:carcreator/pages/collectionRealisticCarPreview.dart';
import 'package:carcreator/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../database_helper.dart';
import '../models/Car.dart';

class CollectionCarPreview extends StatefulWidget {
  final int index;
  const CollectionCarPreview({Key? key, required this.index}) : super(key: key);

  @override
  _CollectionCarPreviewState createState() => _CollectionCarPreviewState();
}

class _CollectionCarPreviewState extends State<CollectionCarPreview> {
  late List<Car> carArray;
  late List<String> svgCodeArray;

  Future<void> refreshCars() async {
    carArray = await CarsDatabase.instance.readAllCars();
    await fillSvgCodeArray();
  }

  Future<void> fillSvgCodeArray() async {
    svgCodeArray = [];
    for (Car car in carArray) {
      svgCodeArray.add(await car.toStringCode());
    }
  }

  Future<void> deleteCar() async {
    await CarsDatabase.instance.delete(carArray[widget.index].id!);
    await refreshCars(); // Refresh the car data
    setState(() {}); // Trigger a rebuild of the widget tree
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    refreshCars();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: refreshCars(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Stack(
              children: [
                _buildChessboard(context),
                _buildLeftCircleWidget(context),
                _buildRightCircleWidget(context),
                _buildArrowBackButton(context),
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
                                Text(
                                  carArray[widget.index].name ?? 'unnamed',
                                  style: const TextStyle(
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
                                    child: SvgPicture.string(
                                      svgCodeArray.isNotEmpty
                                          ? svgCodeArray[widget.index]
                                          : '',
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      height: MediaQuery.of(context).size.width * 0.35,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //btn
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // ElevatedButton(
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //         const CollectionRealisticCarPreview(),
                                    //       ),
                                    //     );
                                    //   },
                                    //   style: ElevatedButton.styleFrom(
                                    //     padding: const EdgeInsets.all(20.0),
                                    //     backgroundColor: Colors.red,
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(40.0),
                                    //     ),
                                    //   ),
                                    //   child: const Text(
                                    //     'Show concept',
                                    //     style: TextStyle(
                                    //       fontSize: 20,
                                    //       color: Colors.white,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                    ElevatedButton(
                                      onPressed: deleteCar,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(20.0),
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                        ),
                                      ),
                                      child: const Text(
                                        'Delete Car',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
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
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
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
