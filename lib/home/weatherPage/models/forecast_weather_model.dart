class ForecastWeatherModel {
  final Map<String, double> dailyAverages; // Store avg temp per day

  ForecastWeatherModel({required this.dailyAverages});

  factory ForecastWeatherModel.fromJson(List<dynamic> jsonList) {
    Map<String, List<double>> dailyTemps = {};

    for (var data in jsonList) {
      try {
        // Safely extract date & temperature
        String? date = data['dt_txt']?.substring(0, 10);
        double? temp = data['main']?['temp'];

        if (date != null && temp != null) {
          if (dailyTemps.containsKey(date)) {
            dailyTemps[date]!.add(temp);
          } else {
            dailyTemps[date] = [temp];
          }
        }
      } catch (e) {
        print("Error parsing forecast data: $e");
      }
    }

    // Compute averages safely
    Map<String, double> averages = {};
    dailyTemps.forEach((date, temps) {
      if (temps.isNotEmpty) {
        averages[date] = temps.reduce((a, b) => a + b) / temps.length;
      }
    });

    return ForecastWeatherModel(dailyAverages: averages);
  }
}
