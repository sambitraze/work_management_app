import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_management_app/Services/authService.dart';
import 'package:work_management_app/Services/baseService.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/User.dart';
import 'package:work_management_app/views/Auth/LoginScreen.dart';
import 'package:work_management_app/views/widgets/commonWidgets.dart';
import 'package:work_management_app/views/widgets/tokenError.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  bool loading = false;
  //TODO: Update this ad wellas backend
  String version = "1.0.0+1";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    var getVersion = await BaseService.getAppCurrentVersion();
    var responseMap = jsonDecode(getVersion);
    if (responseMap['version'] != version) {
      versionErrorWiget(context, responseMap['updateLink']);
    }
    dynamic result = await UserService.getUser();
    if (result == "Your session is expired please login again" ||
        result == "No user was found in DB") {
      tokenErrorWiget(context);
    } else {
      setState(() {
        user = result;
        loading = false;
      });
    }
  }

  logout() async {
    AuthService.clearAuth();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 75),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.cyan.shade200,
                    child: Container(
                      height: 320,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Colors.cyan.shade100.withOpacity(0.5),
                              radius: 75,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.cover,
                                  placeholder: "assets/loader.gif",
                                  image: user.photoUrl.toString(),
                                  imageErrorBuilder:
                                      (context, exception, stackTrace) {
                                    return CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 65,
                                      backgroundImage: AssetImage(
                                        "assets/images/logomain.png",
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                user.name.toString(),
                                style: GoogleFonts.nunito(
                                  fontSize: 24,
                                  color: Colors.cyan.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                user.desgination! +
                                    "(${user.department.toString()})",
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  color: Colors.cyan.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 18,
                                      child: Image.asset(
                                        "assets/images/logomain.png",
                                        height: 20,
                                      ),
                                    ),
                                    onTap: () async {
                                      const uri =
                                          'mailto:majhisambit2@gmail.com?subject=Reach Sambit&body=';
                                      if (await canLaunch(uri)) {
                                        await launch(uri);
                                      } else {
                                        throw 'Could not launch $uri';
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 18,
                                      child: Image.asset(
                                        "assets/images/linkedin.png",
                                        height: 20,
                                      ),
                                    ),
                                    onTap: () async {
                                      const uri =
                                          'https://www.linkedin.com/in/sambitraze/';
                                      if (await canLaunch(uri)) {
                                        await launch(uri);
                                      } else {
                                        throw 'Could not launch $uri';
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 18,
                                      child: Image.asset(
                                        "assets/images/github.png",
                                        height: 20,
                                      ),
                                    ),
                                    onTap: () async {
                                      const uri =
                                          'https://github.com/sambitraze';
                                      if (await canLaunch(uri)) {
                                        await launch(uri);
                                      } else {
                                        throw 'Could not launch $uri';
                                      }
                                    },
                                  ),
                                ],
                                mainAxisSize: MainAxisSize.min,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(onPressed: logout, child: Text("Logout")),
                Text("v " + version)
              ],
            ),
          );
  }
}
