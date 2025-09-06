import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_weather_model.dart';

const String apiKey = 'e39f5c15775b7ceaed981be48fe29e67';
const String city = 'Greater Noida';

class WeatherService {
  Future<WeatherModel> fetchCurrentWeather() async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load current weather data');
    }
  }

  Future<ForecastWeatherModel> fetchForecastWeather() async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    print("API Status Code: ${response.statusCode}");
    print("API Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['list'];
      return ForecastWeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
