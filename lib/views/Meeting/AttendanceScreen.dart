import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/Services/meetingService.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/models/User.dart';

class AttendanceScreen extends StatefulWidget {
  final Meeting meeting;
  const AttendanceScreen({required this.meeting, Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  bool loading = false;
  List<User> userList = [];

  getData() async {
    setState(() {
      loading = true;
    });
    userList = await UserService.getAllUser();
    print(userList.length);
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
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/attendance.png",
                              height: 50,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Attendnace",
                              style: GoogleFonts.nunito(
                                color: Color(0xff141414),
                                fontWeight: FontWeight.w700,
                                fontSize: 36,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            child: Icon(Icons.person_add_alt_1_rounded),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Container(
                                    height: 400,
                                    width: 400,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: userList.length,
                                      itemBuilder: (context, index) => ListTile(
                                        title: Text(
                                          userList[index].name.toString(),
                                        ),
                                        subtitle:  Text(
                                          userList[index].desgination.toString() + " ("+userList[index].department.toString() + ")",
                                        ),
                                        trailing: Icon(
                                          Icons.person_add,
                                          color: Colors.black,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            widget.meeting.attendees!.add(
                                              Attendee(
                                                user: userList[index],
                                                isPresent: false,
                                              ),
                                            );
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.meeting.attendees!.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (BuildContext context, int index) {
                          return attendeeWidget(
                              widget.meeting.attendees![index]);
                        },
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        bool response = await MeetingService.updateMeeting(
                          jsonEncode(
                            widget.meeting.toJson(),
                          ),
                        );
                        if (response) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Attendance Updated"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Attendance updation failed"),
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      color: Color(0xff314B8C),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  attendeeWidget(Attendee attendee) {
    return Container(
      decoration: BoxDecoration(),
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    child: Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        widget.meeting.attendees!.removeWhere(
                            (element) => element.id == attendee.id);
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(attendee.user!.name.toString()),
                      Text(attendee.user!.desgination.toString() +
                          "(" +
                          attendee.user!.department.toString() +
                          ")"),
                    ],
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (attendee.isPresent == true) {
                      attendee.isPresent = false;
                    } else if (attendee.isPresent == false) {
                      attendee.isPresent = true;
                    }
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_people,
                      color: attendee.isPresent == true
                          ? Colors.black
                          : Colors.grey,
                    ),
                    Icon(
                      Icons.accessibility,
                      color: attendee.isPresent == false
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
