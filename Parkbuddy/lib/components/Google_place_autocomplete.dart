import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const String apiKey="AIzaSyBoBYa8xyeWwcFT6ZYmxL8LKnml4FJd3_s";

dynamic placesuggestion (String input)async{//need to be use with a try catch

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

Future<LatLng?> getCoordinatesFromPlaceId(String placeId) async {

  final url = 'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final results = data['results'] as List;


  if (results.isNotEmpty) {
  final geometry = results[0]['geometry'] as Map;
  final location = geometry['location'] as Map;
  final latitude = location['lat'] as double;
  final longitude = location['lng'] as double;
  return LatLng(latitude, longitude);
  } else {
  print('No results found for the given place ID');
  return null;
  }
  } else {
  print('Error fetching coordinates: ${response.body}');
  return null;
  }
}
