import 'dart:convert';

import 'image_data.dart';
import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = 'http://194.87.248.212/api';

  static Future<ImageData> getImage() async {
    var url = Uri.parse('$baseUrl/get');
    try {
      var response = await http.get(
        url
      );
      var textRes = response.body.replaceAll("'", '"');
      var jsonRes = json.decode(textRes);
      var imageData = ImageData.fromJson(jsonRes);
      return imageData;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> submitImage(SubmissionImageData imageData) async {
    var url = Uri.parse('$baseUrl/post');

    print('check1');
    print('${imageData.toJson()}');

    // var response = await http.post(url, body: imageData.toJson());

    return true;
  }
}