// To parse this JSON data, do
//
//     final scheduleActivity = scheduleActivityFromJson(jsonString);

import 'dart:convert';

ScheduleActivity scheduleActivityFromJson(String str) =>
    ScheduleActivity.fromJson(json.decode(str));

String scheduleActivityToJson(ScheduleActivity data) =>
    json.encode(data.toJson());

class ScheduleActivity {
  Data? data;
  String? message;

  ScheduleActivity({
    this.data,
    this.message,
  });

  factory ScheduleActivity.fromJson(Map<String, dynamic> json) =>
      ScheduleActivity(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<CastingCubesSite>? castingCubesSites;
  List<CastingCubesSite>? cubesFromSites;
  List<TodaysTestingSchedule>? todaysTestingSchedule;
  List<Grade>? grades;
  List<CubeElement>? cubeElements;
  List<TestingDay>? testingDays;

  Data({
    this.castingCubesSites,
    this.cubesFromSites,
    this.todaysTestingSchedule,
    this.grades,
    this.cubeElements,
    this.testingDays,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        castingCubesSites: json["casting_cubes_sites"] == null
            ? []
            : List<CastingCubesSite>.from(json["casting_cubes_sites"]!
                .map((x) => CastingCubesSite.fromJson(x))),
        cubesFromSites: json["cubes_from_sites"] == null
            ? []
            : List<CastingCubesSite>.from(json["cubes_from_sites"]!
                .map((x) => CastingCubesSite.fromJson(x))),
        todaysTestingSchedule: json["todays_testing_schedule"] == null
            ? []
            : List<TodaysTestingSchedule>.from(json["todays_testing_schedule"]!
                .map((x) => TodaysTestingSchedule.fromJson(x))),
        grades: json["grades"] == null
            ? []
            : List<Grade>.from(json["grades"]!.map((x) => Grade.fromJson(x))),
        cubeElements: json["cube_elements"] == null
            ? []
            : List<CubeElement>.from(
                json["cube_elements"]!.map((x) => CubeElement.fromJson(x))),
        testingDays: json["testing_days"] == null
            ? []
            : List<TestingDay>.from(
                json["testing_days"]!.map((x) => TestingDay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "casting_cubes_sites": castingCubesSites == null
            ? []
            : List<dynamic>.from(castingCubesSites!.map((x) => x.toJson())),
        "cubes_from_sites": cubesFromSites == null
            ? []
            : List<dynamic>.from(cubesFromSites!.map((x) => x)),
        "todays_testing_schedule": todaysTestingSchedule == null
            ? []
            : List<dynamic>.from(todaysTestingSchedule!.map((x) => x.toJson())),
        "grades": grades == null
            ? []
            : List<dynamic>.from(grades!.map((x) => x.toJson())),
        "cube_elements": cubeElements == null
            ? []
            : List<dynamic>.from(cubeElements!.map((x) => x.toJson())),
        "testing_days": testingDays == null
            ? []
            : List<dynamic>.from(testingDays!.map((x) => x.toJson())),
      };
}

class CastingCubesSite {
  int? id;
  int? projectId;
  int? buildingId;
  int? levelOfConcreting;
  int? elementId;
  int? gradeId;
  int? cubicMeters;
  int? requiredCubes;
  DateTime? proposedDateCasting;
  String? note;
  int? createdBy;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? allocatedCubes;
  String? batchNo;
  int? actualCubeMoulds;
  int? isExternal;
  int? reportRequiredFor;
  String? projectName;
  String? projectLocation;
  String? buildingName;
  String? floorName;
  String? elementName;
  String? gradeName;

  CastingCubesSite({
    this.id,
    this.projectId,
    this.buildingId,
    this.levelOfConcreting,
    this.elementId,
    this.gradeId,
    this.cubicMeters,
    this.requiredCubes,
    this.proposedDateCasting,
    this.note,
    this.createdBy,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.allocatedCubes,
    this.batchNo,
    this.actualCubeMoulds,
    this.isExternal,
    this.reportRequiredFor,
    this.projectName,
    this.projectLocation,
    this.buildingName,
    this.floorName,
    this.elementName,
    this.gradeName,
  });

  factory CastingCubesSite.fromJson(Map<String, dynamic> json) =>
      CastingCubesSite(
        id: json["id"],
        projectId: json["project_id"],
        buildingId: json["building_id"],
        levelOfConcreting: json["level_of_concreting"],
        elementId: json["element_id"],
        gradeId: json["grade_id"],
        cubicMeters: json["cubic_meters"],
        requiredCubes: json["required_cubes"],
        proposedDateCasting: json["proposed_date_casting"] == null
            ? null
            : DateTime.parse(json["proposed_date_casting"]),
        note: json["note"],
        createdBy: json["created_by"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        allocatedCubes: json["allocated_cubes"],
        batchNo: json["batch_no"],
        actualCubeMoulds: json["actual_cube_moulds"],
        isExternal: json["is_external"],
        reportRequiredFor: json["report_required_for"],
        projectName: json["project_name"],
        projectLocation: json["project_location"],
        buildingName: json["building_name"],
        floorName: json["floor_name"],
        elementName: json["element_name"],
        gradeName: json["grade_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "building_id": buildingId,
        "level_of_concreting": levelOfConcreting,
        "element_id": elementId,
        "grade_id": gradeId,
        "cubic_meters": cubicMeters,
        "required_cubes": requiredCubes,
        "proposed_date_casting":
            "${proposedDateCasting!.year.toString().padLeft(4, '0')}-${proposedDateCasting!.month.toString().padLeft(2, '0')}-${proposedDateCasting!.day.toString().padLeft(2, '0')}",
        "note": note,
        "created_by": createdBy,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "allocated_cubes": allocatedCubes,
        "batch_no": batchNo,
        "actual_cube_moulds": actualCubeMoulds,
        "is_external": isExternal,
        "report_required_for": reportRequiredFor,
        "project_name": projectName,
        "project_location": projectLocation,
        "building_name": buildingName,
        "floor_name": floorName,
        "element_name": elementName,
        "grade_name": gradeName,
      };
}

class CubeElement {
  int? id;
  String? elementName;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? elementPrefix;

  CubeElement({
    this.id,
    this.elementName,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.elementPrefix,
  });

  factory CubeElement.fromJson(Map<String, dynamic> json) => CubeElement(
        id: json["id"],
        elementName: json["element_name"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        elementPrefix: json["element_prefix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "element_name": elementName,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "element_prefix": elementPrefix,
      };
}

class Grade {
  int? id;
  String? gradeName;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? dayId;
  int? days;
  String? strength;

  Grade({
    this.id,
    this.gradeName,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.dayId,
    this.days,
    this.strength,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json["id"],
        gradeName: json["grade_name"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        dayId: json["day_id"],
        days: json["days"],
        strength: json["strength"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_name": gradeName,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "day_id": dayId,
        "days": days,
        "strength": strength,
      };
}

class TestingDay {
  int? id;
  int? days;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  TestingDay({
    this.id,
    this.days,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory TestingDay.fromJson(Map<String, dynamic> json) => TestingDay(
        id: json["id"],
        days: json["days"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "days": days,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class TodaysTestingSchedule {
  String? batchNo;
  int? requiredCubes;
  int? cubeCount;
  DateTime? proposedDateCasting;
  String? elementName;
  DateTime? testingDate;
  String? gradeName;
  int? days;

  TodaysTestingSchedule({
    this.batchNo,
    this.requiredCubes,
    this.cubeCount,
    this.proposedDateCasting,
    this.elementName,
    this.testingDate,
    this.gradeName,
    this.days,
  });

  factory TodaysTestingSchedule.fromJson(Map<String, dynamic> json) =>
      TodaysTestingSchedule(
        batchNo: json["batch_no"],
        requiredCubes: json["required_cubes"],
        cubeCount: json["cube_count"],
        proposedDateCasting: json["proposed_date_casting"] == null
            ? null
            : DateTime.parse(json["proposed_date_casting"]),
        elementName: json["element_name"],
        testingDate: json["testing_date"] == null
            ? null
            : DateTime.parse(json["testing_date"]),
        gradeName: json["grade_name"],
        days: json["days"],
      );

  Map<String, dynamic> toJson() => {
        "batch_no": batchNo,
        "required_cubes": requiredCubes,
        "cube_count": cubeCount,
        "proposed_date_casting":
            "${proposedDateCasting!.year.toString().padLeft(4, '0')}-${proposedDateCasting!.month.toString().padLeft(2, '0')}-${proposedDateCasting!.day.toString().padLeft(2, '0')}",
        "element_name": elementName,
        "testing_date":
            "${testingDate!.year.toString().padLeft(4, '0')}-${testingDate!.month.toString().padLeft(2, '0')}-${testingDate!.day.toString().padLeft(2, '0')}",
        "grade_name": gradeName,
        "days": days,
      };
}
