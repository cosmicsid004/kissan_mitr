import 'package:flutter/material.dart';
import 'package:kissan_mitr/common.dart';
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

  String formatDate(String date) {
    try {
      DateTime dt = DateTime.parse(date);
      return "${dt.day} ${_monthName(dt.month)}";
    } catch (e) {
      return date;
    }
  }

  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

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
      backgroundColor: colors.backgroundColor(),

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Temp🌡: ${weather.temperature}°C  ',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Humidity💧: ${weather.humidity}%',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Wind🌬: ${weather.windSpeed}m/s',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
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
      itemCount: forecast.dailyData.length,
      itemBuilder: (context, index) {
        String date = forecast.dailyData.keys.elementAt(index);
        DailyWeather dayData = forecast.dailyData[date]!;

        final animationPath = getWeatherAnimation("clear");
        // TODO: replace with actual `condition` if added in DailyWeather

        return Card(
          color: colors.cardColor(),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Left Side: Text Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatDate(date), // ✅ formatted as 8 Sep
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text("Temp🌡: ${dayData.temp.toStringAsFixed(1)}°C ",
                          style: TextStyle(fontSize: 15)),
                      Text("Humidity💧: ${dayData.humidity}% ",
                          style: TextStyle(fontSize: 15)),
                      Text("Wind🌬: ${dayData.windSpeed.toStringAsFixed(1)} m/s ",
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                // Right Side: Animation
                Lottie.asset(animationPath, height: 60, width: 60),
              ],
            ),
          ),
        );
      },
    );
  }
}