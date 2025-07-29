// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  Data? data;
  String? message;
  bool? status;
  bool? token;

  UserProfile({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  String? location;
  String? mobileNumber;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? encryptPassword;
  dynamic deletedAt;
  String? apiToken;
  dynamic fcmToken;
  String? designation;
  int? userParty;
  String? emergencyContactName;
  String? emergencyContactRelation;
  String? emergencyContactNumber;
  int? idProof;
  String? idProofNumber;
  String? documentPath;
  String? profilePhoto;
  int? isActive;
  dynamic adhaarCardNo;
  int? isSafetyAdmin;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.location,
    this.mobileNumber,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.encryptPassword,
    this.deletedAt,
    this.apiToken,
    this.fcmToken,
    this.designation,
    this.userParty,
    this.emergencyContactName,
    this.emergencyContactRelation,
    this.emergencyContactNumber,
    this.idProof,
    this.idProofNumber,
    this.documentPath,
    this.profilePhoto,
    this.isActive,
    this.adhaarCardNo,
    this.isSafetyAdmin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        location: json["location"],
        mobileNumber: json["mobile_number"],
        role: json["role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        encryptPassword: json["encrypt_password"],
        deletedAt: json["deleted_at"],
        apiToken: json["api_token"],
        fcmToken: json["FCM_token"],
        designation: json["designation"],
        userParty: json["user_party"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactRelation: json["emergency_contact_relation"],
        emergencyContactNumber: json["emergency_contact_number"],
        idProof: json["id_proof"],
        idProofNumber: json["id_proof_number"],
        documentPath: json["document_path"],
        profilePhoto: json["profile_photo"],
        isActive: json["is_active"],
        adhaarCardNo: json["adhaar_card_no"],
        isSafetyAdmin: json["is_safety_admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "location": location,
        "mobile_number": mobileNumber,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "encrypt_password": encryptPassword,
        "deleted_at": deletedAt,
        "api_token": apiToken,
        "FCM_token": fcmToken,
        "designation": designation,
        "user_party": userParty,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_relation": emergencyContactRelation,
        "emergency_contact_number": emergencyContactNumber,
        "id_proof": idProof,
        "id_proof_number": idProofNumber,
        "document_path": documentPath,
        "profile_photo": profilePhoto,
        "is_active": isActive,
        "adhaar_card_no": adhaarCardNo,
        "is_safety_admin": isSafetyAdmin,
      };
}
