// To parse this JSON data, do
//
//     final batchNo = batchNoFromJson(jsonString);

import 'dart:convert';

BatchNo batchNoFromJson(String str) => BatchNo.fromJson(json.decode(str));

String batchNoToJson(BatchNo data) => json.encode(data.toJson());

class BatchNo {
  Data? data;
  String? message;
  bool? status;
  bool? token;

  BatchNo({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory BatchNo.fromJson(Map<String, dynamic> json) => BatchNo(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
        "token": token,
      };
}

class Data {
  int? cubeCastingId;
  List<BatchNoMain>? testingDateList;

  Data({
    this.cubeCastingId,
    this.testingDateList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cubeCastingId: json["cube_casting_id"],
        testingDateList: json["testing_date_list"] == null
            ? []
            : List<BatchNoMain>.from(
                json["testing_date_list"]!.map((x) => BatchNoMain.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cube_casting_id": cubeCastingId,
        "testing_date_list": testingDateList == null
            ? []
            : List<dynamic>.from(testingDateList!.map((x) => x.toJson())),
      };
}

class BatchNoMain {
  int? id;
  int? batchId;
  DateTime? dateOfCasting;
  int? status;
  int? createdBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? cubeCount;
  int? age;
  String? testingDate;
  dynamic remark;
  int? isExternal;
  DateTime? scheduleDate;
  int? ageId;
  String? financialYear;
  int? sequenceNumber;

  BatchNoMain({
    this.id,
    this.batchId,
    this.dateOfCasting,
    this.status,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.cubeCount,
    this.age,
    this.testingDate,
    this.remark,
    this.isExternal,
    this.scheduleDate,
    this.ageId,
    this.financialYear,
    this.sequenceNumber,
  });

  factory BatchNoMain.fromJson(Map<String, dynamic> json) => BatchNoMain(
        id: json["id"],
        batchId: json["batch_id"],
        dateOfCasting: json["date_of_casting"] == null
            ? null
            : DateTime.parse(json["date_of_casting"]),
        status: json["status"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        cubeCount: json["cube_count"],
        age: json["age"],
        testingDate: json["testing_date"],
        remark: json["remark"],
        isExternal: json["is_external"],
        scheduleDate: json["schedule_date"] == null
            ? null
            : DateTime.parse(json["schedule_date"]),
        ageId: json["age_id"],
        financialYear: json["financial_year"],
        sequenceNumber: json["sequence_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "batch_id": batchId,
        "date_of_casting":
            "${dateOfCasting!.year.toString().padLeft(4, '0')}-${dateOfCasting!.month.toString().padLeft(2, '0')}-${dateOfCasting!.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_by": createdBy,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "cube_count": cubeCount,
        "age": age,
        "remark": remark,
        "is_external": isExternal,
        "schedule_date":
            "${scheduleDate!.year.toString().padLeft(4, '0')}-${scheduleDate!.month.toString().padLeft(2, '0')}-${scheduleDate!.day.toString().padLeft(2, '0')}",
        "age_id": ageId,
        "financial_year": financialYear,
        "sequence_number": sequenceNumber,
      };
}
