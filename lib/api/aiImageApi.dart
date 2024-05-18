// import 'dart:convert';
//
// import 'package:carcreator/models/Car.dart';
// import 'package:carcreator/pages/finalRealisticCarPreview.dart';
// import 'package:carcreator/utils/errorDialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:http/http.dart' as http;
//
// Future<dynamic> convertTextToImage(
//   String prompt,
//   Car car,
//   BuildContext context,
// ) async {
//   Uint8List imageData = Uint8List(0);
//
//   const baseUrl = 'https://api.stability.ai';
//   final url = Uri.parse(
//       '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');
//
//   // Make the HTTP POST request to the Stability Platform API
//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization':
//           //add ypur secreat key here
//           'Bearer sk-0lObHkDIUn4fBInI56sU9CMk7NtB389mp4kZ0SE2i4ixcIiy',
//       'Accept': 'image/png',
//     },
//     body: jsonEncode({
//       'cfg_scale': 15,
//       'clip_guidance_preset': 'FAST_BLUE',
//       'height': 512,
//       'width': 512,
//       'samples': 1,
//       'steps': 150,
//       'seed': 0,
//       'style_preset': "3d-model",
//       'text_prompts': [
//         {
//           'text': prompt,
//           'weight': 1,
//         }
//       ],
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     try {
//       EasyLoading.showSuccess('Car Generated');
//       imageData = (response.bodyBytes);
//       Navigator.of(context).push(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => FinalRealisticCarPreview(ourCar: car, image: imageData),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             const begin = Offset(1.0, 0.0);
//             const end = Offset.zero;
//             const curve = Curves.ease;
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);
//             return SlideTransition(
//               position: offsetAnimation,
//               child: child,
//             );
//           },
//         ),
//       );
//       return response.bodyBytes;
//     } on Exception {
//       return showErrorDialog('Failed to generate image', context);
//     }
//   } else {
//     return showErrorDialog('Failed to generate image', context);
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carcreator/models/Car.dart';
import 'package:carcreator/pages/finalRealisticCarPreview.dart';
import 'package:carcreator/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:carcreator/database_helper.dart';


Future<dynamic> convertTextToImage(
    String prompt,
    Car car,
    BuildContext context,
    ) async {
  Uint8List imageData = Uint8List(0);

  const baseUrl = 'https://api.stability.ai';
  final url = Uri.parse(
      '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer sk-0lObHkDIUn4fBInI56sU9CMk7NtB389mp4kZ0SE2i4ixcIiy',
      'Accept': 'image/png',
    },
    body: jsonEncode({
      'cfg_scale': 15,
      'clip_guidance_preset': 'FAST_BLUE',
      'height': 512,
      'width': 512,
      'samples': 1,
      'steps': 150,
      'seed': 0,
      'style_preset': "3d-model",
      'text_prompts': [
        {
          'text': prompt,
          'weight': 1,
        }
      ],
    }),
  );

  if (response.statusCode == 200) {
    try {
      EasyLoading.showSuccess('Car Generated');
      imageData = response.bodyBytes;
      String filePath = await _saveImageLocally(imageData, car.id);
      car.realisticCar = File(filePath);

      await CarsDatabase.instance.update(car);

      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => FinalRealisticCarPreview(ourCar: car, image: imageData),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
      return imageData;
    } on Exception {
      return showErrorDialog('Failed to generate image', context);
    }
  } else {
    return showErrorDialog('Failed to generate image', context);
  }
}

Future<String> _saveImageLocally(Uint8List bytes, int? carId) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File('$dir/${carId}_image.png');
  await file.writeAsBytes(bytes);
  return file.path;
}
