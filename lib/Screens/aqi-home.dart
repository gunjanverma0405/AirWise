import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../models/aqi.dart';
import '../widgets/card.dart';

class AQIPage extends StatefulWidget {
  const AQIPage({Key? key, this.locationAqi}) : super(key: key);
  final locationAqi;

  @override
  State<AQIPage> createState() => _AQIPageState();
}

class _AQIPageState extends State<AQIPage> {
  int aqi = 0;
  String? qname;
  Color? aqiColor;
  var levels = Map();
  List<String> pollutants = [
    'CO',
    'NO',
    'NO\u2082',
    'O\u2083',
    'So\u2082',
    'PM 2.5',
    'PM 10',
    'NH\u2083',
  ];

  AqiModel aqiModel = AqiModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationAqi);
  }

  Future<void> updateUI(dynamic aqiData) async {
    setState(() {
      aqi = aqiData['list'][0]['main']['aqi'];
      levels['CO'] = aqiData['list'][0]['components']['co'];
      levels['NO'] = aqiData['list'][0]['components']['no'];
      levels['NO\u2082'] = aqiData['list'][0]['components']['no2'];
      levels['O\u2083'] = aqiData['list'][0]['components']['o3'];
      levels['So\u2082'] = aqiData['list'][0]['components']['so2'];
      levels['PM 2.5'] = aqiData['list'][0]['components']['pm2_5'];
      levels['PM 10'] = aqiData['list'][0]['components']['pm10'];
      levels['NH\u2083'] = aqiData['list'][0]['components']['nh3'];
      if (aqi == 1) {
        qname = "Good";
        aqiColor = const Color.fromARGB(255, 11, 167, 17);
      } else if (aqi == 2) {
        qname = "Fair";
        aqiColor = const Color.fromARGB(255, 128, 219, 116);
      } else if (aqi == 3) {
        qname = "Moderate";
        aqiColor = const Color(0xFFFFBA00);
      } else if (aqi == 4) {
        qname = "Poor";
        aqiColor = const Color.fromARGB(255, 216, 105, 31);
      } else if (aqi == 5) {
        qname = "Very Poor";
        aqiColor = const Color.fromARGB(255, 171, 0, 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              //color: Colors.black.withOpacity(0.8),
              gradient: RadialGradient(colors: [
            Color.fromARGB(255, 172, 187, 201),
            const Color(0xFF354B5E)
          ], radius: 0.9)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.white.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                    child: SizedBox(
                      width: 220,
                      height: 70,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Air Quality Index: $aqi",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$qname',
                              style: TextStyle(
                                fontSize: 30,
                                color: aqiColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: CircleBorder(),
                  color: Colors.white.withOpacity(0.6),
                  child: SizedBox(
                    height: 310,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          showLabels: false,
                          // showAxisLine: false,
                          showTicks: false,
                          startAngle: 180,
                          endAngle: 0,
                          minimum: 0.5,
                          maximum: 5.5,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0.5,
                              endValue: 1.5,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFF1B5E20),
                                Color(0xFFB2FF59)
                              ]),
                            ),
                            GaugeRange(
                              startValue: 1.5,
                              endValue: 2.5,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFB2FF59),
                                Color(0xFFFFEB3B)
                              ]),
                            ),
                            GaugeRange(
                              startValue: 2.5,
                              endValue: 3.5,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFFFEB3B),
                                Color(0xFFFF6F00)
                              ]),
                            ),
                            GaugeRange(
                              startValue: 3.5,
                              endValue: 4.5,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFFF6F00),
                                Color(0xFFD50000)
                              ]),
                            ),
                            GaugeRange(
                              startValue: 4.5,
                              endValue: 5.5,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFB50000),
                                Color.fromARGB(255, 59, 1, 1)
                              ]),
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.blue, Colors.green],
                                ).createShader(bounds),
                                child: Text(
                                  '$qname',
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Open Sans',
                                    letterSpacing: 2,
                                    height: 1.2,
                                    color: Colors.black,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.5),
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.5,
                            ),
                          ],

                          pointers: <GaugePointer>[
                            NeedlePointer(
                                value: aqi.toDouble(),
                                enableAnimation: true,
                                animationType: AnimationType.ease,
                                needleColor: aqiColor!,
                                needleStartWidth: 1,
                                needleEndWidth: 5,
                                knobStyle: KnobStyle(knobRadius: 0))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyCardWidget(
                  pollutants: pollutants,
                  levels: levels,
                  aqiColor: aqiColor,
                ),
                const SizedBox(
                  height: 19.5,
                ),
              ],
            ),
          )),
    );
  }
}
