import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/dynamic_form_model.dart';
import 'package:weather/repo/get_dynamic_form_data.dart';
import 'package:weather/repo/post_form_data.dart';
import 'package:weather/utility/connectivity.dart';
import 'package:weather/utility/shared_preference.dart';
import 'package:weather/view/home_page.dart';
import 'package:workmanager/workmanager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final service = FlutterBackgroundService();
var connection;
Connectivity connectivity = Connectivity();
var internetChecker = InternetConnectionChecker();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  connectivity.onConnectivityChanged.listen((val) {
    connection = val;
  });
  var path = await getExternalStorageDirectory();
  Hive.init(path!.path);
  Hive.registerAdapter(DynamicFormAdapter());
  Hive.registerAdapter(FieldAdapter());
  Hive.registerAdapter(MetaInfoAdapter());
  await BackgroundTask().startBackgroundTask();
  var box = await Hive.openBox<DynamicForm>('box');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetDyanamicFormData()),
        ChangeNotifierProvider(create: (context) => PostDyanamicFormData()),
      ],
      child: MaterialApp(
        title: 'Dynamic Form App',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
