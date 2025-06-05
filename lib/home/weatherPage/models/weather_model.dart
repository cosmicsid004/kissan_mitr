class WeatherModel {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String condition;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      condition: json['weather'][0]['main'].toLowerCase(),
    );
  }
}
