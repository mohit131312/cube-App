// To parse this JSON data, do
//
//     final viewTestModel = viewTestModelFromJson(jsonString);

import 'dart:convert';

ViewTestModel viewTestModelFromJson(String str) =>
    ViewTestModel.fromJson(json.decode(str));

String viewTestModelToJson(ViewTestModel data) => json.encode(data.toJson());

class ViewTestModel {
  List<CardResult>? data;
  String? message;
  bool? status;
  bool? token;

  ViewTestModel({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory ViewTestModel.fromJson(Map<String, dynamic> json) => ViewTestModel(
        data: json["data"] == null
            ? []
            : List<CardResult>.from(
                json["data"]!.map((x) => CardResult.fromJson(x))),
        message: json["message"],
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "token": token,
      };
}

class CardResult {
  int? id;
  DateTime? testingDate;
  int? status;
  String? batchNo;
  DateTime? proposedDateCasting;
  String? labAddress;
  int? age;
  DateTime? scheduleDate;

  CardResult({
    this.id,
    this.testingDate,
    this.status,
    this.batchNo,
    this.proposedDateCasting,
    this.labAddress,
    this.age,
    this.scheduleDate,
  });

  factory CardResult.fromJson(Map<String, dynamic> json) => CardResult(
        id: json["id"],
        testingDate: json["testing_date_tr"] == null
            ? null
            : DateTime.parse(json["testing_date_tr"]),
        status: json["status"],
        batchNo: json["batch_no"],
        proposedDateCasting: json["proposed_date_casting"] == null
            ? null
            : DateTime.parse(json["proposed_date_casting"]),
        labAddress: json["lab_address"],
        age: json["age"],
        scheduleDate: json["schedule_date_tr"] == null
            ? null
            : DateTime.parse(json["schedule_date_tr"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "testing_date":
            "${testingDate!.year.toString().padLeft(4, '0')}-${testingDate!.month.toString().padLeft(2, '0')}-${testingDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "batch_no": batchNo,
        "proposed_date_casting":
            "${proposedDateCasting!.year.toString().padLeft(4, '0')}-${proposedDateCasting!.month.toString().padLeft(2, '0')}-${proposedDateCasting!.day.toString().padLeft(2, '0')}",
        "lab_address": labAddress,
        "age": age,
      };
}
