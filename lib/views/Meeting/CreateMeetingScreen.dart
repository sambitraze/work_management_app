import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/Services/meetingService.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/models/User.dart';
import 'package:work_management_app/views/widgets/commonWidgets.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      height: 75,
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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
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
                  onPressed: () {
                    if (attendees.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Add atleast 1 Participant")));
                    } else {}
                    MeetingService.createMeeting("payload");
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
                        setState(() {
                          controller.text =
                              '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}    ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}';
                          controller2.text = date.toString();
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          controller.text =
                              '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}    ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}';
                          controller2.text = date.toString();
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
