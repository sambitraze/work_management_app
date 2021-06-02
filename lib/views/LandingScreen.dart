import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_management_app/views/Auth/LoginScreen.dart';
import 'package:work_management_app/views/Services/authService.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          child: Text("Logout"),
          onPressed: () async{
            AuthService.clearAuth();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("login", false);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
