class ForecastWeatherModel {
  final Map<String, DailyWeather> dailyData; // date → weather data

  ForecastWeatherModel({required this.dailyData});

  factory ForecastWeatherModel.fromJson(List<dynamic> jsonList) {
    Map<String, List<double>> dailyTemps = {};
    Map<String, List<int>> dailyHumidity = {};
    Map<String, List<double>> dailyWind = {};

    for (var data in jsonList) {
      try {
        // Extract date
        String? date = data['dt_txt']?.substring(0, 10);

        double? temp = data['main']?['temp'];
        int? humidity = data['main']?['humidity'];
        double? windSpeed = data['wind']?['speed'];

        if (date != null && temp != null && humidity != null && windSpeed != null) {
          dailyTemps.putIfAbsent(date, () => []).add(temp);
          dailyHumidity.putIfAbsent(date, () => []).add(humidity);
          dailyWind.putIfAbsent(date, () => []).add(windSpeed);
        }
      } catch (e) {
        print("Error parsing forecast data: $e");
      }
    }

    // Compute daily averages
    Map<String, DailyWeather> dailyData = {};
    dailyTemps.forEach((date, temps) {
      if (temps.isNotEmpty) {
        double avgTemp = temps.reduce((a, b) => a + b) / temps.length;
        int avgHumidity = (dailyHumidity[date]!.reduce((a, b) => a + b) / dailyHumidity[date]!.length).round();
        double avgWind = dailyWind[date]!.reduce((a, b) => a + b) / dailyWind[date]!.length;

        dailyData[date] = DailyWeather(
          temp: avgTemp,
          humidity: avgHumidity,
          windSpeed: avgWind,
        );
      }
    });

    return ForecastWeatherModel(dailyData: dailyData);
  }
}

class DailyWeather {
  final double temp;
  final int humidity;
  final double windSpeed;

  DailyWeather({
    required this.temp,
    required this.humidity,
    required this.windSpeed,
  });
}



