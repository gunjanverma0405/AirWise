import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/forecast.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  final _cityController = TextEditingController();
  List<WeatherForecast> _forecastData = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeatherForecast() async {
    final city = _cityController.text;
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=5e907d0ecd336b872084b2c295aa8ca4';

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(url));

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final forecastList = jsonData['list'] as List<dynamic>;
      final forecastData =
          forecastList.map((item) => WeatherForecast.fromJson(item)).toList();
      setState(() {
        _forecastData = forecastData;
      });
    } else {
      throw Exception('Failed to fetch weather forecast');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Enter a city name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _fetchWeatherForecast,
          child:
              _isLoading ? CircularProgressIndicator() : Text('Get Forecast'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _forecastData.length,
            itemBuilder: (context, index) {
              final forecast = _forecastData[index];
              return ListTile(
                leading: Image.network(forecast.iconUrl),
                title: Text(forecast.date),
                subtitle: Text('${forecast.temperature} °C'),
              );
            },
          ),
        ),
      ],
    );
  }
}
