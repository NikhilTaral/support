import 'dart:convert';

GetAllValidationUsersResponseModel getAllValidationUsersResponseModelFromJson(
        String str) =>
    GetAllValidationUsersResponseModel.fromJson(json.decode(str));

String getAllValidationUsersResponseModelToJson(
        GetAllValidationUsersResponseModel data) =>
    json.encode(data.toJson());

class GetAllValidationUsersResponseModel {
  final List<UserName>? data;
  final bool? success;
  final num? failCode;
  final String? message;

  GetAllValidationUsersResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  GetAllValidationUsersResponseModel copyWith({
    List<UserName>? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      GetAllValidationUsersResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );

  factory GetAllValidationUsersResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetAllValidationUsersResponseModel(
        data: json["data"] == null
            ? []
            : List<UserName>.from(
                json["data"]?.map((x) => UserName.fromJson(x))),
        success: json["success"],
        failCode: json["failCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data?.map((x) => x.toJson())??[]),
        "success": success,
        "failCode": failCode,
        "message": message,
      };
}

class UserName {
  final String? name;
  final String? email;

  UserName({
    this.name,
    this.email,
  });

  UserName copyWith({
    String? name,
    String? email,
  }) =>
      UserName(
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory UserName.fromJson(Map<String, dynamic> json) => UserName(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}
