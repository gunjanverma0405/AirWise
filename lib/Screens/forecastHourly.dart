import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../models/forecast.dart';

class ForecastHourly extends StatefulWidget {
  @override
  _ForecastHourlyState createState() => _ForecastHourlyState();
}

class _ForecastHourlyState extends State<ForecastHourly> {
  List<WeatherForecast> _forecastData = [];
  bool _isLoading = false;
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final hasPermission = await _location.requestPermission();
    if (hasPermission != PermissionStatus.granted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Access Denied'),
          content: Text('Please grant location access to use this app'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      await _fetchWeatherForecastForCurrentLocation();
    }
  }

  Future<void> _fetchWeatherForecastForCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final locationData = await _location.getLocation();
      final latitude = locationData.latitude!;
      final longitude = locationData.longitude!;
      final url =
          'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=5e907d0ecd336b872084b2c295aa8ca4';

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
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to get current location'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        if (!_isLoading)
          Expanded(
            child: ListView(
              children: _forecastData.map((forecast) {
                return Card(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          forecast.date,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.network(
                          forecast.iconUrl,
                          width: 50.0,
                          height: 50.0,
                        ),
                        Text(
                          '${forecast.temperature.toStringAsFixed(1)} °C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )
      ],
    );
  }
}
