// To parse this JSON data, do
//
//     final concertingModel = concertingModelFromJson(jsonString);

import 'dart:convert';

ConcertingModel concertingModelFromJson(String str) =>
    ConcertingModel.fromJson(json.decode(str));

String concertingModelToJson(ConcertingModel data) =>
    json.encode(data.toJson());

class ConcertingModel {
  List<ConcertingLevel>? data;
  String? message;
  bool? status;
  bool? token;

  ConcertingModel({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory ConcertingModel.fromJson(Map<String, dynamic> json) =>
      ConcertingModel(
        data: json["data"] == null
            ? []
            : List<ConcertingLevel>.from(
                json["data"]!.map((x) => ConcertingLevel.fromJson(x))),
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

class ConcertingLevel {
  int? id;
  String? floorName;
  int? floorCategory;

  ConcertingLevel({
    this.id,
    this.floorName,
    this.floorCategory,
  });

  factory ConcertingLevel.fromJson(Map<String, dynamic> json) =>
      ConcertingLevel(
        id: json["id"],
        floorName: json["floor_name"],
        floorCategory: json["floor_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "floor_name": floorName,
        "floor_category": floorCategory,
      };
}
