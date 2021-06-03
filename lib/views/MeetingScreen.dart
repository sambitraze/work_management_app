import 'package:flutter/material.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/User.dart';
import 'package:work_management_app/views/widgets/commonWidgets.dart';
import 'package:work_management_app/views/widgets/tokenError.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late User user;
  bool loading = false;
  List meetings = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
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
                  headerWidget(user, context),
                  Expanded(
                    child: ListView.builder(
                      itemCount: meetings.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return meetingWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
