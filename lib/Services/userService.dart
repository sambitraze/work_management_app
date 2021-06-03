import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:work_management_app/models/User.dart';

import 'authService.dart';

class UserService extends AuthService {
  // ignore: missing_return
  static Future getUser() async {
    var auth = await AuthService.getSavedAuth();
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + '/user/user/${auth['id']}',
        method: 'GET');
    var responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      User user = User.fromJson(responseMap);
      return user;
    } else {
      return responseMap["message"];
    }
  }

  // // ignore: missing_return
  // static Future<User> getUserById(id) async {
  //   http.Response response = await AuthService.makeAuthenticatedRequest(
  //       AuthService.BASE_URI + 'api/user/$id}',
  //       method: 'GET');
  //   if (response.statusCode == 200) {
  //     User user = User.fromJson(json.decode(response.body));
  //     return user;
  //   } else {
  //     print("DEBUG");
  //   }
  // }

  // // ignore: missing_return
  static Future getAllUser() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + '/user/',
        method: 'GET');
    var responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      List<User> users =
          responseMap.map<User>((usersMap) => User.fromJson(usersMap)).toList();
      return users;
    } else {
      return responseMap["message"];
    }
  }

  // static Future<bool> updateUser(var payload) async {
  //   var auth = await AuthService.getSavedAuth();
  //   http.Response response = await AuthService.makeAuthenticatedRequest(
  //       AuthService.BASE_URI + 'api/user/update/${auth['id']}',
  //       method: 'PUT',
  //       body: payload);
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     print("Debug update user");
  //     return false;
  //   }
  // }

  static Future getUserCount() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + '/user/count',
        method: 'GET');

    var responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseMap["usercount"];
    } else {
      return responseMap["message"];
    }
  }
}
