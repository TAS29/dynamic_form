import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future shouldCallApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool("should_call_api") ?? false;
  }

  shouldCallApiStatusUpdate(bool val) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("should_call_api", val);
  }

  saveApiData(List<Map<String, dynamic>> data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("data", data.toString());
  }

  getApiData(List<Map<String, dynamic>> data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getString("data");
  }
}
