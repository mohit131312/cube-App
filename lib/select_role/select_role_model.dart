// To parse this JSON data, do
//
//     final assignRole = assignRoleFromJson(jsonString);

import 'dart:convert';

AssignRole assignRoleFromJson(String str) =>
    AssignRole.fromJson(json.decode(str));

String assignRoleToJson(AssignRole data) => json.encode(data.toJson());

class AssignRole {
  List<SelectRole>? data;
  String? message;
  bool? status;
  bool? token;

  AssignRole({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory AssignRole.fromJson(Map<String, dynamic> json) => AssignRole(
        data: json["data"] == null
            ? []
            : List<SelectRole>.from(
                json["data"]!.map((x) => SelectRole.fromJson(x))),
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

class SelectRole {
  int? id;
  int? projectAssignUserId;
  int? userId;
  int? roleId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  RoleName? roleName;

  SelectRole({
    this.id,
    this.projectAssignUserId,
    this.userId,
    this.roleId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.roleName,
  });

  factory SelectRole.fromJson(Map<String, dynamic> json) => SelectRole(
        id: json["id"],
        projectAssignUserId: json["project_assign_user_id"],
        userId: json["user_id"],
        roleId: json["role_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        roleName: json["role_name"] == null
            ? null
            : RoleName.fromJson(json["role_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_assign_user_id": projectAssignUserId,
        "user_id": userId,
        "role_id": roleId,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role_name": roleName?.toJson(),
      };
}

class RoleName {
  int? id;
  String? serialNo;
  String? roleName;
  String? roleAbbreviation;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? dashboard;
  int? projectList;
  int? setup;
  int? reviewChecklist;
  int? rera;
  int? progressReport;
  int? tasks;
  int? reports;
  int? userType;
  int? reviewHoChecklist;
  int? requestCubeCasting;
  int? cubeTestResult;
  int? cubeCasting;
  int? safetyAdmin;

  RoleName({
    this.id,
    this.serialNo,
    this.roleName,
    this.roleAbbreviation,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.dashboard,
    this.projectList,
    this.setup,
    this.reviewChecklist,
    this.rera,
    this.progressReport,
    this.tasks,
    this.reports,
    this.userType,
    this.reviewHoChecklist,
    this.requestCubeCasting,
    this.cubeTestResult,
    this.cubeCasting,
    this.safetyAdmin,
  });

  factory RoleName.fromJson(Map<String, dynamic> json) => RoleName(
        id: json["id"],
        serialNo: json["serial_no"],
        roleName: json["role_name"],
        roleAbbreviation: json["role_abbreviation"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        dashboard: json["dashboard"],
        projectList: json["project_list"],
        setup: json["setup"],
        reviewChecklist: json["review_checklist"],
        rera: json["rera"],
        progressReport: json["progress_report"],
        tasks: json["tasks"],
        reports: json["reports"],
        userType: json["user_type"],
        reviewHoChecklist: json["review_ho_checklist"],
        requestCubeCasting: json["request_cube_casting"],
        cubeTestResult: json["cube_test_result"],
        cubeCasting: json["cube_casting"],
        safetyAdmin: json["safety_admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial_no": serialNo,
        "role_name": roleName,
        "role_abbreviation": roleAbbreviation,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "dashboard": dashboard,
        "project_list": projectList,
        "setup": setup,
        "review_checklist": reviewChecklist,
        "rera": rera,
        "progress_report": progressReport,
        "tasks": tasks,
        "reports": reports,
        "user_type": userType,
        "review_ho_checklist": reviewHoChecklist,
        "request_cube_casting": requestCubeCasting,
        "cube_test_result": cubeTestResult,
        "cube_casting": cubeCasting,
        "safety_admin": safetyAdmin,
      };
}
