import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  shouldCallApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
     sp.getBool("should_call_api") ?? false;
  }

  shouldCallApiStatusUpdate(bool val) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool("should_call_api", val);
  }

  saveApiData(List<Map<String, dynamic>> data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
   await sp.setString("data", data.toString());
  }

  getApiData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getString("data");
  }
}
