import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

dynamic placesuggestion (String input)async{//need to be use with a try catch
  const String apiKey="AIzaSyBoBYa8xyeWwcFT6ZYmxL8LKnml4FJd3_s";
  const String session_token="1234567890";
  try {
    String bassedUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$bassedUrl?input=$input&key=$apiKey&sessiontoken=$session_token';
    var response = await http.get(Uri.parse(request));
    var data = json.decode(response.body);
    if (kDebugMode) {
      print(data);
    }
    if (response.statusCode == 200) {

      var listOfLocation = json.decode(response.body)['predictions'];
      return listOfLocation;
    } else {
      throw Exception("Fail to load");

    }

  } catch (e) {
    return e;
  }
}
