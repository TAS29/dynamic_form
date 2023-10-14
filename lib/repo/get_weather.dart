import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather/constants/urls.dart';
import 'package:weather/main.dart';
import 'package:weather/models/weather_model.dart';

class GetWether with ChangeNotifier {
  WeatherModel? data;
  bool loading = true;

  getWeatherData() async {
    try {
      loading=true;
      notifyListeners();
      Dio dio = Dio();
      Response res = await dio.get(getWeatherUrl);
      if (res.statusCode == 200) {
        loading = false;
        data = weatherModelFromJson(jsonEncode(res.data));
        notifyListeners();
        return;
      } else if (res.statusCode == 400) {data=null;
        loading = true;
        notifyListeners();
        print(res.statusCode.toString());
      }
    } on DioError catch (e) {
      loading = true;
      notifyListeners();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
     const SnackBar(
        content: Text('Error Getting Weather Data!'),
        duration: Duration(seconds: 3),
      ),
    );
      // errorMessage();
      print(e.toString());
    }
  }
}
