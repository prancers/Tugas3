import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'location.dart';

class WeatherService {
  double? temperature;
  String? weatherIcon;
  String? cityName;

  final API_KEY = "c6e19053b0db2c67b56343e2f33b2a04";

  Future<dynamic> getWeatherData() async {
    LocationService s = LocationService();
    await s.getCurrentLocation();

    double? lat = s.latitude;
    double? lon = s.longitude;

    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API_KEY&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      var weatherData = jsonDecode(data);
      temperature = weatherData['main']['temp'];
      weatherIcon = weatherData['weather'][0]['icon'];
      cityName = weatherData['name'];
    }
  }
}
