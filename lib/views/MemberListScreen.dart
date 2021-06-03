import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/User.dart';
import 'package:work_management_app/views/widgets/tokenError.dart';

class MemeberListScreen extends StatefulWidget {
  const MemeberListScreen({Key? key}) : super(key: key);

  @override
  _MemeberListScreenState createState() => _MemeberListScreenState();
}

class _MemeberListScreenState extends State<MemeberListScreen> {
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  int count = 0;
  List<User> userList = [];

  getData() async {
    setState(() {
      loading = true;
    });
    dynamic msg = await UserService.getUserCount();
    if (msg == "Your session is expired please login again" ||
        msg == "user count error") {
      tokenErrorWiget(context);
    } else {
      setState(() {
        count = msg;
      });
    }
    dynamic result = await UserService.getAllUser();
    if (result == "Your session is expired please login again" ||
        result == "No USERS are found") {
      tokenErrorWiget(context);
    } else {
      setState(() {
        userList = result;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  ListTile(
                    leading: Icon(Icons.card_membership),
                    title: Text(
                      "Member List",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      count.toString(),
                      style: GoogleFonts.nunito(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userList.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return memberCard(userList[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  memberCard(User user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name.toString(),
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.desgination.toString() +
                          "(${user.department.toString()})",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
