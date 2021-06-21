import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/Services/meetingService.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/models/User.dart';
import 'package:work_management_app/views/Meeting/CreateMeetingScreen.dart';
import 'package:work_management_app/views/widgets/commonWidgets.dart';

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
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    user = await UserService.getUser();
    meetings = await MeetingService.getAllMeeting();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xff314B8C),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateMeetingScreen(
                      user: user,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.add,
              ),
            ),
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
                      padding: const EdgeInsets.all(16.0),
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
