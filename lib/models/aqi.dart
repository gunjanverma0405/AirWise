import 'location.dart';
import 'networking.dart';

const airPollutionUrl = 'http://api.openweathermap.org/data/2.5/air_pollution';
String apiKey = '881eb049488db6ed9b2eb9e4902ae419';

class AqiModel {
  Future<dynamic> getLocationAQI() async {
    LocationService location = LocationService();
    await location.getCurrentPosition();
    NetworkHelper networkHelper = NetworkHelper(
        '$airPollutionUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    var aqiData = await networkHelper.getData();
    return aqiData;
  }
}
