// To parse this JSON data, do
//
//     final viewTestDetails = viewTestDetailsFromJson(jsonString);

import 'dart:convert';

ViewTestDetails viewTestDetailsFromJson(String str) =>
    ViewTestDetails.fromJson(json.decode(str));

String viewTestDetailsToJson(ViewTestDetails data) =>
    json.encode(data.toJson());

class ViewTestDetails {
  List<DetailsResult>? data;
  String? message;
  bool? status;
  bool? token;

  ViewTestDetails({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory ViewTestDetails.fromJson(Map<String, dynamic> json) =>
      ViewTestDetails(
        data: json["data"] == null
            ? []
            : List<DetailsResult>.from(
                json["data"]!.map((x) => DetailsResult.fromJson(x))),
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

class DetailsResult {
  DateTime? dateOfCasting;
  DateTime? testingDate;
  int? id;
  int? batchId;
  int? castingId;
  int? cubeId;
  int? age;
  String? remark;
  String? length;
  String? width;
  String? height;
  String? weight;
  String? load;
  int? createdBy;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isExternal;
  String? recordNo;
  String? csArea;
  String? density;
  String? compStrenght;
  String? labAddress;
  DateTime? scheduleDate;
  String? batchNo;
  String? groupAbv;
  String? projectAbv;
  String? buildingAbv;
  String? financialYear;
  int? sequenceNumber;

  DetailsResult({
    this.dateOfCasting,
    this.testingDate,
    this.id,
    this.batchId,
    this.castingId,
    this.cubeId,
    this.age,
    this.remark,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.load,
    this.createdBy,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isExternal,
    this.recordNo,
    this.csArea,
    this.density,
    this.compStrenght,
    this.labAddress,
    this.scheduleDate,
    this.batchNo,
    this.groupAbv,
    this.projectAbv,
    this.buildingAbv,
    this.financialYear,
    this.sequenceNumber,
  });

  factory DetailsResult.fromJson(Map<String, dynamic> json) => DetailsResult(
        dateOfCasting: json["date_of_casting"] == null
            ? null
            : DateTime.parse(json["date_of_casting"]),
        testingDate: json["testing_date"] == null
            ? null
            : DateTime.parse(json["testing_date"]),
        id: json["id"],
        batchId: json["batch_id"],
        castingId: json["casting_id"],
        cubeId: json["cube_id"],
        age: json["age"],
        remark: json["remark"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        weight: json["weight"],
        load: json["load"],
        createdBy: json["created_by"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isExternal: json["is_external"],
        recordNo: json["record_no"],
        csArea: json["cs_area"],
        density: json["density"],
        compStrenght: json["comp_strenght"],
        labAddress: json["lab_address"],
        scheduleDate: json["schedule_date"] == null
            ? null
            : DateTime.parse(json["schedule_date"]),
        batchNo: json["batch_no"],
        groupAbv: json["group_abv"],
        projectAbv: json["project_abv"],
        buildingAbv: json["building_abv"],
        financialYear: json["financial_year"],
        sequenceNumber: json["sequence_number"],
      );

  Map<String, dynamic> toJson() => {
        "date_of_casting":
            "${dateOfCasting!.year.toString().padLeft(4, '0')}-${dateOfCasting!.month.toString().padLeft(2, '0')}-${dateOfCasting!.day.toString().padLeft(2, '0')}",
        "testing_date":
            "${testingDate!.year.toString().padLeft(4, '0')}-${testingDate!.month.toString().padLeft(2, '0')}-${testingDate!.day.toString().padLeft(2, '0')}",
        "id": id,
        "batch_id": batchId,
        "casting_id": castingId,
        "cube_id": cubeId,
        "age": age,
        "remark": remark,
        "length": length,
        "width": width,
        "height": height,
        "weight": weight,
        "load": load,
        "created_by": createdBy,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_external": isExternal,
        "record_no": recordNo,
        "cs_area": csArea,
        "density": density,
        "comp_strenght": compStrenght,
        "lab_address": labAddress,
        "schedule_date":
            "${scheduleDate!.year.toString().padLeft(4, '0')}-${scheduleDate!.month.toString().padLeft(2, '0')}-${scheduleDate!.day.toString().padLeft(2, '0')}",
        "batch_no": batchNo,
        "group_abv": groupAbv,
        "project_abv": projectAbv,
        "building_abv": buildingAbv,
        "financial_year": financialYear,
        "sequence_number": sequenceNumber,
      };
}
