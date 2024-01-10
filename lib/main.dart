import 'package:flutter/material.dart';
import 'package:flutter_application_budget_app_using_sqflite/splashScreen/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Creating Budget App',
        home: SplashScreen());
  }
}
