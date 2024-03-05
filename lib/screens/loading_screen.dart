import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eclima/services/location.dart';
import 'package:http/http.dart' as http;

const String apiKey = '2646e30c1807e13501accb3b3d57acd7';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=$apiKey');

  void getLocation() async {
    Location location = Location();

    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  }

  void getWeatherData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      dynamic decodedData = jsonDecode(data);

      double temp = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print(temp);
      print(condition);
      print(cityName);
    } else {
      print('Things went wrong!');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
