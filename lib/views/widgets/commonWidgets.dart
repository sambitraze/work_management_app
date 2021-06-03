import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/models/User.dart';

meetingWidget() {}

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
              backgroundImage: AssetImage("assets/images/dummy.png"),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, "+user.name.toString().split(" ")[0],
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 22,
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
  );
}
