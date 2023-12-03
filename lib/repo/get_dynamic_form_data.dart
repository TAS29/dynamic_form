import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/constants/urls.dart';
import 'package:weather/main.dart';
import 'package:weather/models/dynamic_form_model.dart';
import 'package:weather/repo/post_form_data.dart';

class GetDyanamicFormData with ChangeNotifier {
  DynamicForm? data;
  bool loading = true;
  int numberOfMandatoryFields = 0;

  getDyanamicFormDataData() async {
    numberOfMandatoryFields = 0;
    try {
      loading = true;
      notifyListeners();
      Dio dio = Dio();
      Response res = await dio.get(dyanamicFormDataUrl);
      if (res.statusCode == 200) {
        loading = false;
        data = dynamicFormFromJson(jsonEncode(res.data));
        data!.fields.forEach((e) {
          if (e.metaInfo.mandatory == "yes") {
            numberOfMandatoryFields++;
          }
        });
        notifyListeners();
        return;
      } else if (res.statusCode == 400) {
        data = null;
        loading = true;
        notifyListeners();
        print(res.statusCode.toString());
      }
    } on DioError catch (e) {
      loading = true;
      notifyListeners();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Error Getting Data!'),
          duration: Duration(seconds: 3),
        ),
      );
      // errorMessage();
      print(e.toString());
    }
  }
}
