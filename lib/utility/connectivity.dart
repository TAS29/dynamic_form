import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/main.dart';
import 'package:weather/utility/shared_preference.dart';

class BackgroundTask {
  postDyanamicFormDataData() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      Dio dio = Dio();
      Response res = await dio.post("https://chatbot-api.grampower.com/flutter-assignment/push", data: {"data": sp.getString("data")});
      print(res.toString());
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  startBackgroundTask() async {
    try {
      connectivity.onConnectivityChanged.listen((val) async {
              print("network change");
        if (connection != ConnectivityResult.none) {
          if (await internetChecker.hasConnection) {
              print("connected");
            SharedPreferences sp = await SharedPreferences.getInstance();
            var shouldCallApi = sp.getBool("should_call_api") ?? false;
            var data = sp.getString("data");
            if (shouldCallApi) {
              print("api called");
              await postDyanamicFormDataData();
              await sp.setBool("should_call_api", false);
            }
          }
        }
      });
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
