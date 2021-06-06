import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/views/widgets/commonWidgets.dart';

class MeetingDetailScreen extends StatefulWidget {
  final Meeting meeting;
  const MeetingDetailScreen({required this.meeting, Key? key})
      : super(key: key);

  @override
  _MeetingDetailScreenState createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Meeting Details',
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
              titleWidget(
                context,
                "Topic: ",
                widget.meeting.topic.toString(),
              ),
              titleWidget(
                context,
                "Agenda: ",
                widget.meeting.desc.toString(),
              ),
              titleWidget(
                context,
                "Date: ",
                dateWidget(widget.meeting.start),
              ),
              titleWidget(
                context,
                "Start: ",
                timeWidget(widget.meeting.start),
              ),
              titleWidget(
                context,
                "End: ",
                timeWidget(widget.meeting.end),
              ),
              titleWidget(
                context,
                "Mom: ",
                widget.meeting.mom.toString(),
              ),
              titleWidget(
                context,
                "Total Participants: ",
                widget.meeting.mom.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
