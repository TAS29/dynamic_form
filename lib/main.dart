import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/repo/get_dynamic_form_data.dart';
import 'package:weather/repo/post_form_data.dart';
import 'package:weather/utility/connectivity.dart';
import 'package:weather/view/home_page.dart';

void main() async {
  runApp(MyApp());
  InternetConnectivity().checkConnection();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
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
        home:   const HomePage(),
      ),
    );
  }
}
