import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/weather_services.dart';
import '../models/weather_model.dart';
import '../models/forecast_weather_model.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<WeatherModel> currentWeather;
  late Future<ForecastWeatherModel> forecastWeather;

  @override
  void initState() {
    super.initState();
    currentWeather = WeatherService().fetchCurrentWeather();
    forecastWeather = WeatherService().fetchForecastWeather();
  }


  String getWeatherAnimation(String condition) {
    if (condition.contains('clear')) {
      return 'assets/weatherIcon/sunny.json';
    } else if (condition.contains('cloud')) {
      return 'assets/weatherIcon/cloudy.json';
    } else if (condition.contains('rain')) {
      return 'assets/weatherIcon/rainy.json';
    } else if (condition.contains('thunder')) {
      return 'assets/weatherIcon/Thunder.json';
    } else {
      return 'assets/weatherIcon/sunny.json'; // Default animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFFCA),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FutureBuilder<WeatherModel>(
              future: currentWeather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading weather data'));
                } else {
                  final weather = snapshot.data!;
                  final animationPath = getWeatherAnimation(weather.condition);

                  return Column(
                    children: [
                      SizedBox(height: 50),
                      Text('Greater Noida', style: TextStyle(fontSize: 22)),
                      Lottie.asset(animationPath, height: 150),
                      Text('Temp: ${weather.temperature}°C', style: TextStyle(fontSize: 18)),
                      Text('Humidity: ${weather.humidity}%', style: TextStyle(fontSize: 18)),
                      Text('Wind Speed: ${weather.windSpeed} m/s', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                    ],
                  );
                }
              },
            ),
            Expanded(
              child: FutureBuilder<ForecastWeatherModel>(
                future: forecastWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading forecast'));
                  } else {
                    final forecast = snapshot.data!;
                    return _buildForecast(forecast);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecast(ForecastWeatherModel forecast) {
    return ListView.builder(
      itemCount: forecast.dailyAverages.length,
      itemBuilder: (context, index) {
        String date = forecast.dailyAverages.keys.elementAt(index);
        double avgTemp = forecast.dailyAverages[date]!;

        return Card(
          color: const Color(0xFF84AE92),
          child: ListTile(
            title: Text(date),
            subtitle: Text('Temp: ${avgTemp.toStringAsFixed(1)}°C'),
            trailing: Icon(Icons.thermostat),
          ),
        );
      },
    );
  }
}

