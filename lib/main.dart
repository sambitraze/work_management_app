import 'package:flutter/material.dart';
import 'package:work_management_app/views/Auth/LoginScreen.dart';
import 'package:work_management_app/views/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoT Lab WMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SplashScreen(),
    );
  }
}