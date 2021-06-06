import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_management_app/Services/authService.dart';
import 'package:work_management_app/views/Auth/LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialButton(onPressed: () async {
          AuthService.clearAuth();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("login", false);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },)
    );
  }
}