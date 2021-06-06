// To parse this JSON data, do
//
//     final meeting = meetingFromJson(jsonString);

import 'dart:convert';

import 'package:work_management_app/models/User.dart';

List<Meeting> meetingFromJson(String str) => List<Meeting>.from(json.decode(str).map((x) => Meeting.fromJson(x)));

String meetingToJson(List<Meeting> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Meeting {
    Meeting({
        this.id,
        this.start,
        this.end,
        this.date,
        this.topic,
        this.desc,
        this.createdBy,
        this.meetLink,
        this.mom,
        this.attendees,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? id;
    DateTime? start;
    DateTime? end;
    String? date;
    String? topic;
    String? desc;
    User? createdBy;
    String? meetLink;
    String? mom;
    List<Attendee>? attendees;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        id: json["_id"] == null ? null : json["_id"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        date: json["date"] == null ? null : json["date"],
        topic: json["topic"] == null ? null : json["topic"],
        desc: json["desc"] == null ? null : json["desc"],
        createdBy: json["createdBy"] == null ? null : User.fromJson(json["createdBy"]),
        meetLink: json["meetLink"] == null ? null : json["meetLink"],
        mom: json["mom"] == null ? null : json["mom"],
        attendees: json["attendees"] == null ? null : List<Attendee>.from(json["attendees"].map((x) => Attendee.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "start": start == null ? null : start.toString(),
        "end": end == null ? null : end.toString(),
        "date": date == null ? null : date,
        "topic": topic == null ? null : topic,
        "desc": desc == null ? null : desc,
        "createdBy": createdBy == null ? null : createdBy!.toJson(),
        "meetLink": meetLink == null ? null : meetLink,
        "mom": mom == null ? null : mom,
        "attendees": attendees == null ? null : List<dynamic>.from(attendees!.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt.toString(),
        "updatedAt": updatedAt == null ? null : updatedAt.toString(),
        "__v": v == null ? null : v,
    };
}

class Attendee {
    Attendee({
        this.isPresent,
        this.id,
        this.user,
    });

    bool? isPresent;
    String? id;
    User? user;

    factory Attendee.fromJson(Map<String, dynamic> json) => Attendee(
        isPresent: json["isPresent"] == null ? null : json["isPresent"],
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),        
    );

    Map<String, dynamic> toJson() => {
        "isPresent": isPresent == null ? null : isPresent,
        "_id": id == null ? null : id,
        "user": user == null ? null : user!.toJson(),
    };
}


