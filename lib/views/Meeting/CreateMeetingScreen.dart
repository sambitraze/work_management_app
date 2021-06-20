import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/Services/meetingService.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/models/User.dart';
import 'package:work_management_app/views/LandingScreen.dart';
import 'package:work_management_app/views/widgets/commonWidgets.dart';
import 'package:http/http.dart' as http;

class CreateMeetingScreen extends StatefulWidget {
  final User user;
  const CreateMeetingScreen({required this.user});

  @override
  _CreateMeetingScreenState createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  late Meeting meeting;
  bool loading = false;
  List<User> userList = [];
  List<Attendee> attendees = [];
  TextEditingController topicController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController startController2 = TextEditingController();
  TextEditingController endController2 = TextEditingController();
  TextEditingController meetLinKController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    userList = await UserService.getAllUser();
    setState(() {
      loading = false;
    });
  }

  bool submitLoader = false;

  checkFields() {
    if (topicController.text.length > 0 &&
        descController.text.length > 0 &&
        startController2.text.length > 0 &&
        endController2.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  late http.Response response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/meet.png",
                      height: 60,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Create Meeting",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              formheaderWidget(context, 'Topic'),
              SizedBox(
                height: 8,
              ),
              inputWidget(topicController, "Please Enter Topic", false, 1, 1),
              SizedBox(
                height: 16,
              ),
              formheaderWidget(context, 'Description'),
              SizedBox(
                height: 8,
              ),
              inputWidget(
                  descController, "Please Enter Description", false, 100, 5),
              SizedBox(
                height: 16,
              ),
              inputDateTime("Start Time", startController, startController2),
              SizedBox(
                height: 16,
              ),
              inputDateTime("End Time", endController, endController2),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  formheaderWidget(context, "Enter Google Meet"),
                  Text(
                    "(Leave empty for auto generation)",
                    style: GoogleFonts.nunito(fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              inputWidget(
                  meetLinKController, "Please Enter Meet Url", false, 100, 1),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formheaderWidget(context, 'Participants'),
                  InkWell(
                    child: Icon(Icons.person_add),
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
                                subtitle: Text(
                                  userList[index].desgination.toString() +
                                      " (" +
                                      userList[index].department.toString() +
                                      ")",
                                ),
                                trailing: Icon(
                                  Icons.person_add,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  setState(() {
                                    attendees.add(
                                      Attendee(
                                        user: userList[index],
                                        isPresent: false,
                                      ),
                                    );
                                  });
                                  print(attendees.length);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: attendees.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  print(attendees.length);
                  return ListTile(
                    title: Text(
                      attendees[index].user!.name.toString(),
                    ),
                    subtitle: Text(
                      attendees[index].user!.desgination.toString() +
                          " (" +
                          attendees[index].user!.department.toString() +
                          ")",
                    ),
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        attendees.removeWhere((element) =>
                            element.user!.id == attendees[index].user!.id);
                      });
                    },
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      "Create",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  color: Color(0xff314B8C),
                  onPressed: () async {
                    if (attendees.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Add atleast 1 Participant")));
                    } else {
                      if (checkFields()) {
                        if (meetLinKController.text.length == 0) {
                          var payload2 = {
                            "topic": topicController.text,
                            "type": 2,
                            "start_time": startController2.text,
                            "duration": 40,
                            "timezone": "Asia/Kolkata",
                            "agenda": descController.text,
                            "settings": {
                              "join_before_host": true,
                              "mute_upon_entry": true,
                              "approval_type": 0,
                              "waiting_room": false
                            }
                          };
                          var res =
                              await MeetingService.createMeetLink(payload2);
                          if (res != false) {
                            print("api");
                            var payload = {
                              "topic": topicController.text,
                              "desc": descController.text,
                              "date": startController.text.split(" ")[0],
                              "start": startController2.text,
                              "end": endController2.text,
                              "createdBy": widget.user.id,
                              "meetLink": res,
                              "attendees": List<dynamic>.from(
                                  attendees.map((x) => x.toJson())),
                            };
                            bool response = await MeetingService.createMeeting(
                                jsonEncode(payload));
                            if (response) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Meeting created")));
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LandingScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("meeting creation failed")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Meeting Link Creation faield")));
                          }
                        } else {
                          var payload = {
                            "topic": topicController.text,
                            "desc": descController.text,
                            "date": startController.text.split(" ")[0],
                            "start": startController2.text,
                            "end": endController2.text,
                            "createdBy": widget.user.id,
                            "meetLink": meetLinKController.text,
                            "attendees": List<dynamic>.from(
                                attendees.map((x) => x.toJson())),
                          };
                          bool response = await MeetingService.createMeeting(
                              jsonEncode(payload));
                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Meeting created")));
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LandingScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("meeting creation failed")));
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Check All Field")));
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  inputDateTime(label, controller, controller2) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: GoogleFonts.nunito(
                      color: Color(0xff314B8C),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Color(0xff314B8C),
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onChanged: (date) {
                        DateTime date1 = date.toUtc();
                        setState(() {
                          controller.text =
                              '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}    ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}';
                          controller2.text = date1.toString();
                        });
                      },
                      onConfirm: (date) {
                        DateTime date1 = date.toUtc();
                        setState(() {
                          controller.text =
                              '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}    ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}';
                          controller2.text = date1.toString();
                        });
                      },
                      currentTime: DateTime.now(),
                    );
                  },
                  child: Text(
                    "Select",
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff314B8C).withOpacity(0.12),
            ),
            child: TextField(
              enabled: false,
              style: TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.list_alt,
                  color: Colors.black,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
