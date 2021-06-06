import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/Services/meetingService.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/Meeting.dart';
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
  List<Meeting> meetings = [];

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
    dynamic result2 = await MeetingService.getAllMeeting();
    if (result == "Your session is expired please login again" ||
        result == "No user was found in DB") {
      tokenErrorWiget(context);
    } else {
      setState(() {
        user = result;
      });
    }
    if (result2 == "Your session is expired please login again" ||
        result2 == "No meetings are foundB") {
      tokenErrorWiget(context);
    } else {
      setState(() {
        meetings = result2;
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                      "Meetings",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                                    ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: meetings.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return meetingWidget(context, meetings[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
