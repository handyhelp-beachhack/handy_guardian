// To parse this JSON data, do
//
//     final jobModel = jobModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

JobModel jobModelFromMap(String str) => JobModel.fromMap(json.decode(str));

String jobModelToMap(JobModel data) => json.encode(data.toMap());

class JobModel {
  JobModel({
    required this.id,
    required this.jobType,
    required this.createdAt,
    required this.name,
    required this.endDate,
    required this.description,
    required this.handicapType,
    required this.lpa,
    required this.contactNumber,
    required this.postedBy,
    required this.jobId,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String jobType;
  DateTime createdAt;
  String name;
  DateTime endDate;
  String description;
  String handicapType;
  int lpa;
  String contactNumber;
  String postedBy;
  String jobId;
  DateTime updatedAt;
  int v;

  factory JobModel.fromMap(Map<String, dynamic> json) => JobModel(
        id: json["_id"],
        jobType: json["job_type"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        endDate: DateTime.parse(json["end_date"]),
        description: json["description"],
        handicapType: json["handicap_type"],
        lpa: json["lpa"],
        contactNumber: json["contact_number"],
        postedBy: json["posted_by"],
        jobId: json["job_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "job_type": jobType,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "end_date": endDate.toIso8601String(),
        "description": description,
        "handicap_type": handicapType,
        "lpa": lpa,
        "contact_number": contactNumber,
        "posted_by": postedBy,
        "job_id": jobId,
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}