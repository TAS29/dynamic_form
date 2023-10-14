import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/repo/get_weather.dart';
import 'package:weather/view/home_page.dart';

void main() {
  runApp( MyApp());
}
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
   MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>GetWether())
        ],
        child: const HomePage()),
    );
  }
}


