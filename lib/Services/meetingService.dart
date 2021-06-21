import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:work_management_app/Services/baseService.dart';
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/views/Meeting/CreateMeetingScreen.dart';

import 'authService.dart';

class MeetingService extends AuthService {
  // ignore: missing_return
  static Future getAllMeeting() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        BaseService.BASE_URI + '/meeting/',
        method: 'GET');
    var responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      List<Meeting> meeting = responseMap
          .map<Meeting>((meetingMap) => Meeting.fromJson(meetingMap))
          .toList();
      print(meeting.length);
      return meeting;
    } else {
      return responseMap["message"];
    }
  }

  // ignore: missing_return
  static Future createMeeting(payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        BaseService.BASE_URI + '/meeting/create',
        method: 'POST',
        body: payload);
    // var responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Meeting meeting = Meeting.fromJson(responseMap);
      return true;
    } else {
      return false;
    }
  }

  static Future createMeetLink(var payload) async {
    http.Response response = await http.post(
      Uri.parse("https://api.zoom.us/v2/users/wms@iotkiit.in/meetings"),
      body: jsonEncode(payload),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6IlFrOVlzZk5PUzdhNXZBMzJNWjI2bkEiLCJleHAiOjE3NjcyMDU1MDAsImlhdCI6MTYyNDIxMTQyMn0.uER7Cz8DeZ2uEV2DGFSVITu82E8NuI8vCCVkksqlyhY"
      },
    );
      print(response.body);
    if (response.statusCode == 201) {
      var responseMap = jsonDecode(response.body);
      return responseMap["join_url"];
    } else {
      return false;
    }
  }

  static Future<bool> updateMeeting(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        BaseService.BASE_URI + '/meeting/update/',
        method: 'PUT',
        body: payload);
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Debug update meeting");
      return false;
    }
  }
}
