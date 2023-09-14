import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../provider/weatherProvider.dart';

class MainWeather extends StatelessWidget {
  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Container(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined),
                Text(
                  '${weatherProv.weather.cityName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              DateFormat.yMMMEd().add_jm().format(DateTime.now()),
              style: _style2,
            ),
            const SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MapString.mapStringToIcon(
                  context,
                  '${weatherProv.weather.currently}',
                  100,
                ),
                SizedBox(width: 16.0),
                Text(
                  '${weatherProv.weather.temp.toStringAsFixed(0)}°C',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Text(
              '${weatherProv.weather.tempMax.toStringAsFixed(0)}°/ ${weatherProv.weather.tempMin.toStringAsFixed(0)}°',
              style: _style1.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 5.0),
            Text(
              toBeginningOfSentenceCase('${weatherProv.weather.description}') ??
                  '',
              style: _style1.copyWith(fontSize: 19),
            ),
            SizedBox(height: 25.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Column(
            //       children: [
            //         Text(
            //           'Temperature',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 20.0,
            //           ),
            //         ),
            //         SizedBox(height: 8.0),
            //         Text(
            //           '70°F',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 28.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           'Wind',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 20.0,
            //           ),
            //         ),
            //         SizedBox(height: 8.0),
            //         Text(
            //           '10 mph',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 28.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           'Humidity',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 20.0,
            //           ),
            //         ),
            //         SizedBox(height: 8.0),
            //         Text(
            //           '50%',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 28.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      );
    });
  }
}
