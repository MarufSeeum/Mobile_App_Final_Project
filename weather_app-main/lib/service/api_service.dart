import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app_1/constants/constant.dart';
import '../model/weathermodel.dart';

class ApiService {
  Future<WeatherModel> getWeatherData(String searchText) async {
    String url = "$base_url&q=$searchText&days=7";

    try {
      Response responce = await get(Uri.parse(url));
      if (responce.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(responce.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        throw ("No data found");
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
