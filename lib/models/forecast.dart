class WeatherForecast {
  final String date;
  final double temperature;
  final String iconUrl;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.iconUrl,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final date = json['dt_txt'] as String;
    final temperature = (json['main']['temp'] as num).toDouble() -
        273.15; // Convert from Kelvin to Celsius
    final iconCode = json['weather'][0]['icon'] as String;
    final iconUrl =
        'https://openweathermap.org/img/wn/$iconCode.png'; // Get the icon URL from the icon code
    return WeatherForecast(
      date: date,
      temperature: temperature,
      iconUrl: iconUrl,
    );
  }
}
