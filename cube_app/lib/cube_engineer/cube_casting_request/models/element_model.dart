// To parse this JSON data, do
//
//     final elementModel = elementModelFromJson(jsonString);

import 'dart:convert';

ElementModel elementModelFromJson(String str) =>
    ElementModel.fromJson(json.decode(str));

String elementModelToJson(ElementModel data) => json.encode(data.toJson());

class ElementModel {
  List<ElementList>? data;
  String? message;
  bool? status;
  bool? token;

  ElementModel({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory ElementModel.fromJson(Map<String, dynamic> json) => ElementModel(
        data: json["data"] == null
            ? []
            : List<ElementList>.from(
                json["data"]!.map((x) => ElementList.fromJson(x))),
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

class ElementList {
  int? id;
  String? elementName;

  ElementList({
    this.id,
    this.elementName,
  });

  factory ElementList.fromJson(Map<String, dynamic> json) => ElementList(
        id: json["id"],
        elementName: json["element_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "element_name": elementName,
      };
}
