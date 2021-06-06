// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.blocked,
    this.isverified,
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.phone,
    this.roll,
    this.dob,
    this.desgination,
    this.photoUrl,
    this.department,
  });

  bool? blocked;
  bool? isverified;
  String? id;
  String? name;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? phone;
  String? roll;
  String? photoUrl;
  String? dob;
  String? desgination;
  String? department;

  factory User.fromJson(Map<String, dynamic> json) => User(
        blocked: json["blocked"] == null ? null : json["blocked"],
        isverified: json["isverified"] == null ? null : json["isverified"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        phone: json["phone"] == null ? null : json["phone"],
        roll: json["roll"] == null ? null : json["roll"],
        dob: json["dob"] == null ? null : json["dob"],
        photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
        desgination: json["desgination"] == null ? null : json["desgination"],
        department: json["department"] == null ? null : json["department"],
      );

  Map<String, dynamic> toJson() => {
        "blocked": blocked == null ? null : blocked,
        "isverified": isverified == null ? null : isverified,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "__v": v == null ? null : v,
        "phone": phone == null ? null : phone,
        "roll": roll == null ? null : roll,
        "dob": dob == null ? null : dob,
        "photoUrl": photoUrl == null ? null : photoUrl,
        "desgination": desgination == null ? null : desgination,
        "department": department == null ? null : department,
      };
}
