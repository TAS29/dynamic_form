import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/main.dart';
import 'package:weather/repo/post_form_data.dart';
import 'package:weather/utility/shared_preference.dart';

class InternetConnectivity {
  var isDeviceConnected = false;

  checkConnection() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (isDeviceConnected) {
          final shouldCallApi = await LocalStorage().shouldCallApi();
          if (shouldCallApi) {
            await navigatorKey.currentContext!.read<PostDyanamicFormData>().postDyanamicFormDataData();
            LocalStorage().shouldCallApiStatusUpdate(false);
          }
        }
      }
    });
  }
}
