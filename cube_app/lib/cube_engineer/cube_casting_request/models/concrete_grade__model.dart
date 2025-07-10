// To parse this JSON data, do
//
//     final concreteModel = concreteModelFromJson(jsonString);

import 'dart:convert';

ConcreteModel concreteModelFromJson(String str) =>
    ConcreteModel.fromJson(json.decode(str));

String concreteModelToJson(ConcreteModel data) => json.encode(data.toJson());

class ConcreteModel {
  List<ConcreteGrade>? data;
  String? message;
  bool? status;
  bool? token;

  ConcreteModel({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory ConcreteModel.fromJson(Map<String, dynamic> json) => ConcreteModel(
        data: json["data"] == null
            ? []
            : List<ConcreteGrade>.from(
                json["data"]!.map((x) => ConcreteGrade.fromJson(x))),
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

class ConcreteGrade {
  int? id;
  String? gradeName;

  ConcreteGrade({
    this.id,
    this.gradeName,
  });

  factory ConcreteGrade.fromJson(Map<String, dynamic> json) => ConcreteGrade(
        id: json["id"],
        gradeName: json["grade_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_name": gradeName,
      };
}
