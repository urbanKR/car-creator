import 'dart:convert';

import 'package:carcreator/models/Car.dart';
import 'package:carcreator/pages/finalRealisticCarPreview.dart';
import 'package:carcreator/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

Future<dynamic> convertTextToImage(
  String prompt,
  Car car,
  BuildContext context,
) async {
  Uint8List imageData = Uint8List(0);

  const baseUrl = 'https://api.stability.ai';
  final url = Uri.parse(
      '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');

  // Make the HTTP POST request to the Stability Platform API
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          //add ypur secreat key here
          'Bearer sk-4hzRK8PujzBFLmBx0TKOV0HxGPOEobJx7t2fxWkn9QAqkFr7',
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
      imageData = (response.bodyBytes);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FinalRealisticCarPreview(ourCar: car, image: imageData),
        ),
      );
      return response.bodyBytes;
    } on Exception {
      return showErrorDialog('Failed to generate image', context);
    }
  } else {
    return showErrorDialog('Failed to generate image', context);
  }
}
