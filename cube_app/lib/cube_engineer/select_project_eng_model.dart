// To parse this JSON data, do
//
//     final assignProject = assignProjectFromJson(jsonString);

import 'dart:convert';

AssignProject assignProjectFromJson(String str) =>
    AssignProject.fromJson(json.decode(str));

String assignProjectToJson(AssignProject data) => json.encode(data.toJson());

class AssignProject {
  List<ProjectModel>? data;
  String? message;
  bool? status;
  bool? token;

  AssignProject({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory AssignProject.fromJson(Map<String, dynamic> json) => AssignProject(
        data: json["data"] == null
            ? []
            : List<ProjectModel>.from(
                json["data"]!.map((x) => ProjectModel.fromJson(x))),
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

class ProjectModel {
  int? projectId;
  String? projectName;
  int? buildingId;
  String? buildingName;

  ProjectModel({
    this.projectId,
    this.projectName,
    this.buildingId,
    this.buildingName,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        projectId: json["project_id"],
        projectName: json["project_name"],
        buildingId: json["building_id"],
        buildingName: json["building_name"],
      );

  Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "project_name": projectName,
        "building_id": buildingId,
        "building_name": buildingName,
      };
}
