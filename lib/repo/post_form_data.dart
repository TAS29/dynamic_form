import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/constants/urls.dart';
import 'package:weather/main.dart';
import 'package:weather/models/dynamic_form_model.dart';
import 'package:weather/repo/get_dynamic_form_data.dart';
import 'package:weather/repo/post_form_data.dart';

class PostDyanamicFormData with ChangeNotifier {
  List<String> editTextValues = [];
  List<String> dropDownValues = [];
  List<List<String>> selectedOptionsList = [];
  List<int> selectedOptionIndices = [];
  Uint8List? imageFile;
  bool loading = true;
  List<Map<String, dynamic>>? formData;

  captureImage(val) {
    imageFile = val;
    notifyListeners();
  }

  updateFormData() {
    notifyListeners();
  }

  updateRadioButton(int value, int index) {
    while (selectedOptionIndices.length <= index) {
      selectedOptionIndices.add(-1);
    }

    selectedOptionIndices[index] = value;
    notifyListeners();
  }

  void onSelected(bool selected, String dataName, int index) {
    while (selectedOptionsList.length <= index) {
      selectedOptionsList.add([]);
    }
    if (selected == true) {
      selectedOptionsList[index].add(dataName);
    } else {
      selectedOptionsList[index].remove(dataName);
    }
    notifyListeners();
  }

  void updateEditText(String value, int index) {
    if (index < editTextValues.length) {
      editTextValues[index] = value;
    } else {
      editTextValues.add(value);
    }
    notifyListeners();
  }

  void updateDropDownValue(String value, int index) {
    if (index < dropDownValues.length) {
      dropDownValues[index] = value;
    } else {
      dropDownValues.add(value);
    }
    notifyListeners();
  }


  postDyanamicFormDataData() async {
    try {
      loading = true;
      notifyListeners();
      Dio dio = Dio();
      Response res = await dio.post(postDyanamicFormDataUrl, data: {"data": formData});
      print(res.toString());
      if (res.statusCode == 201) {
        loading = false;
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(res.data["message"]),
          ),
        );
        notifyListeners();
        return;
      } else if (res.statusCode == 400) {
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
      print(e.toString());
    }
  }
}
