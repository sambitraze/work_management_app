import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:work_management_app/models/Meeting.dart';
import 'package:work_management_app/views/Meeting/CreateMeetingScreen.dart';

import 'authService.dart';

class MeetingService extends AuthService {
  // ignore: missing_return
  static Future getAllMeeting() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + '/meeting/',
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
        AuthService.BASE_URI + '/meeting/create',
        method: 'POST',
        body: payload);
    var responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Meeting meeting = Meeting.fromJson(responseMap);
      return meeting;
    } else {
      return "error";
    }
  }

  // // ignore: missing_return
  // static Future getAllUser() async {
  //   http.Response response = await AuthService.makeAuthenticatedRequest(
  //       AuthService.BASE_URI + '/user/',
  //       method: 'GET');
  //   var responseMap = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     List<User> users =
  //         responseMap.map<User>((usersMap) => User.fromJson(usersMap)).toList();
  //     return users;
  //   } else {
  //     return responseMap["message"];
  //   }
  // }

  static Future<bool> updateMeeting(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + '/meeting/update/',
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
