import 'dart:convert';

GetAllValidationUsersResponceModel getAllValidationUsersResponceModelFromJson(
        String str) =>
    GetAllValidationUsersResponceModel.fromJson(json.decode(str));

String getAllValidationUsersResponceModelToJson(
        GetAllValidationUsersResponceModel data) =>
    json.encode(data.toJson());

class GetAllValidationUsersResponceModel {
  final List<Datum>? data;
  final bool? success;
  final int? failCode;
  final String? message;

  GetAllValidationUsersResponceModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  GetAllValidationUsersResponceModel copyWith({
    List<Datum>? data,
    bool? success,
    int? failCode,
    String? message,
  }) =>
      GetAllValidationUsersResponceModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );

  factory GetAllValidationUsersResponceModel.fromJson(
          Map<String, dynamic> json) =>
      GetAllValidationUsersResponceModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        success: json["success"],
        failCode: json["failCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "failCode": failCode,
        "message": message,
      };
}

class Datum {
  final String? name;
  final String? email;

  Datum({
    this.name,
    this.email,
  });

  Datum copyWith({
    String? name,
    String? email,
  }) =>
      Datum(
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}
