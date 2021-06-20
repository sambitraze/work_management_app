import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/models/User.dart';
import 'package:work_management_app/views/Meeting/AttendanceScreen.dart';
import 'package:work_management_app/views/Meeting/MeetingDetailScreen.dart';

colorBorder(Meeting? meeting) {
  if (meeting!.start!.isBefore(DateTime.now()) &&
      meeting.end!.isAfter(DateTime.now()))
    return Colors.purple.shade700;
  else if (meeting.start!.isBefore(DateTime.now()) &&
      meeting.end!.isBefore(DateTime.now()))
    return Colors.green.shade700;
  else if (meeting.start!.isAfter(DateTime.now()) &&
      meeting.end!.isAfter(DateTime.now()))
    return Colors.grey.shade700;
  else
    return Colors.white;
}

meetingWidget(context, Meeting? meeting) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    child: InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 4.0,
              color: colorBorder(meeting),
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meeting!.topic.toString(),
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      dateWidget(meeting.start!.toLocal()),
                      style: GoogleFonts.nunito(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "at",
                      style: GoogleFonts.nunito(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      timeWidget(meeting.start!.toLocal()),
                      style: GoogleFonts.nunito(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      "-",
                      style: GoogleFonts.nunito(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      timeWidget(meeting.end!.toLocal()),
                      style: GoogleFonts.nunito(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    meeting.start!.isBefore(DateTime.now()) &&
                            meeting.end!.isAfter(DateTime.now())
                        ? inProgress()
                        : Container(),
                    meeting.start!.isBefore(DateTime.now()) &&
                            meeting.end!.isBefore(DateTime.now())
                        ? completed()
                        : Container(),
                    meeting.start!.isAfter(DateTime.now()) &&
                            meeting.end!.isAfter(DateTime.now())
                        ? notStarted()
                        : Container(),
                    SizedBox(
                      width: 16,
                    ),
                    meeting.attendees!.length >= 1
                        ? CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: NetworkImage(
                              meeting.attendees![0].user!.photoUrl.toString(),
                            ),
                          )
                        : Container(),
                    meeting.attendees!.length >= 2
                        ? CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: NetworkImage(
                              meeting.attendees![1].user!.photoUrl.toString(),
                            ),
                          )
                        : Container(),
                    meeting.attendees!.length >= 3
                        ? CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: NetworkImage(
                              meeting.attendees![2].user!.photoUrl.toString(),
                            ),
                          )
                        : Container(),
                    meeting.attendees!.length >= 4
                        ? CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: NetworkImage(
                              meeting.attendees![3].user!.photoUrl.toString(),
                            ),
                          )
                        : Container(),
                    meeting.attendees!.length >= 5
                        ? CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: NetworkImage(
                              meeting.attendees![4].user!.photoUrl.toString(),
                            ),
                          )
                        : Container(),
                    meeting.attendees!.length >= 6
                        ? CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            child: Text(
                              "+" + (meeting.attendees!.length - 5).toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Meeting Actions',
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Divider(
                          color: Color(0xff314B8C),
                          thickness: 2.5,
                          indent: 100,
                          endIndent: 100,
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            await canLaunch(meeting.meetLink.toString())
                                ? await launch(meeting.meetLink.toString())
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Invalid Meeting Link",
                                      ),
                                      duration: Duration(milliseconds: 800),
                                    ),
                                  );
                          },
                          child: actionCard("Join Meet", "meet"),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AttendanceScreen(
                                  meeting: meeting,
                                ),
                              ),
                            );
                          },
                          child: actionCard("Attendance", "attendance"),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MeetingDetailScreen(meeting: meeting),
                              ),
                            );
                          },
                          child: actionCard("Details", "details"),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

actionCard(label, image) {
  return Container(
    height: 100,
    width: 100,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "assets/images/$image.png",
            height: 50,
          ),
          Text(label),
        ],
      ),
    ),
  );
}

Widget titleWidget(BuildContext context, String label, String data) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            color: Color(0xff141414),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: GoogleFonts.nunito(
              color: Color(0xff141414),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        )
      ],
    ),
  );
}

completed() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(36),
      color: Colors.green.shade200,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            color: Colors.green.shade700,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "Completed",
            style: GoogleFonts.nunito(
              color: Colors.green.shade700,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

notStarted() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(36),
      color: Colors.grey.shade300,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            color: Colors.grey.shade700,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "Not Started",
            style: GoogleFonts.nunito(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

inProgress() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(36),
      color: Colors.purple.shade200,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, color: Colors.purple.shade900),
          SizedBox(
            width: 6,
          ),
          Text(
            "In Progress",
            style: GoogleFonts.nunito(
              color: Colors.purple.shade900,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

dateWidget(DateTime? date) {
  return "${date?.day}/${date?.month}/${date?.year}";
}

timeWidget(DateTime? date) {
  return "${date?.hour.toString().padLeft(2, '0')}:${date?.minute.toString().padLeft(2, '0')}";
}

headerWidget(User user, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: NetworkImage(user.photoUrl.toString()),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, " + user.name.toString().split(" ")[0],
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  user.desgination.toString() +
                      "(${user.department.toString()})",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget formheaderWidget(BuildContext context, String text) {
  return Text(
    text,
    style: GoogleFonts.nunito(
        color: Color(0xff314B8C), fontSize: 18, fontWeight: FontWeight.bold),
  );
}

Widget inputWidget(TextEditingController textEditingController,
    String validation, bool, maxline, minline) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Color(0xff314B8C).withOpacity(0.12),
    ),
    child: TextFormField(
      enabled: true,
      obscureText: bool,
      maxLines: maxline,
      minLines: minline,
      validator: (value) => value!.isEmpty ? validation : null,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        // suffixIcon: Icon(
        //   Icons.list_alt,
        //   color: Colors.black,
        // ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(20),
      ),
      controller: textEditingController,
    ),
  );
}

versionErrorWiget(BuildContext context,String uri) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Text("Please update the app!!!"),
      actions: [
        MaterialButton(
          child: Text("Update"),
          onPressed: () async {
            if (await canLaunch(uri)) {
              await launch(uri);
            } else {
              throw 'Could not launch $uri';
            }
          },
        ),
      ],
    ),
  );
}
