import 'package:carcreator/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:carcreator/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDto7NEYlA6j_gxEzxPyaEWtbK6oR7Gc0w',
        appId: '1:304805834413:android:c7347943a0b6a75ec86024',
        messagingSenderId: '304805834413',
        projectId: 'carcreator-42a6a')
  );
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 55.0
    ..radius = 10.0
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RacingSansOne'),
      home: const WidgetTree(),
      builder: EasyLoading.init(),
    );
  }
}
