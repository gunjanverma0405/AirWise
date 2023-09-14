import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/aqi.dart';
import 'aqi-home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    AqiModel aqiModel = AqiModel();
    var aqiData = await aqiModel.getLocationAQI();
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AQIPage(locationAqi: aqiData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 58, 19, 196),
      child: Center(
          child: SpinKitChasingDots(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
