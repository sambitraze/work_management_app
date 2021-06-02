import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_management_app/views/Auth/LoginScreen.dart';
import 'package:work_management_app/Services/authService.dart';
import 'package:work_management_app/views/HomeScreen.dart';
import 'package:work_management_app/views/MeetingScreen.dart';
import 'package:work_management_app/views/MemberListScreen.dart';
import 'package:work_management_app/views/ProfileScreen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
   int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // ReminderService reminderService;
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         content:
    //         Text(message.notification.body),
    //         title: Text(message.notification.title),
    //       ));
    //   // if (message.data != null) {
    //   //   print('Message also contained a notification: ${message.notification}');
    //   //   reminderService.sheduledNotification(
    //   //       message.data['startTime'], message.data['endTime']);
    //   // }
    // });
    // _selectedIndex = widget.selectedIndex;
  }
  // MaterialButton(
  //         child: Text("Logout"),
  //         onPressed: () async{
  //           AuthService.clearAuth();
  //           SharedPreferences prefs = await SharedPreferences.getInstance();
  //           prefs.setBool("login", false);
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) => LoginScreen(),
  //             ),
  //           );
  //         },
  //       ),

  List<Widget> _widgetOptions = <Widget>[
    MeetingScreen(),
    MemeberListScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
       bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Color(0xff314B8C),
              hoverColor: Color(0xff314B8C),
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: Color(0xff314B8C),
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.house_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.person_search,
                  text: 'Users',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Settings',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      
    );
  }
}
