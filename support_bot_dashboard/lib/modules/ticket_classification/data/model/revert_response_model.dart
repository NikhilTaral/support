import 'dart:convert';

RevertResponseModel revertResponseModelFromJson(String str) =>
    RevertResponseModel.fromJson(json.decode(str));

String revertResponseModelToJson(RevertResponseModel data) =>
    json.encode(data.toJson());

class RevertResponseModel {
  final Data? data;
  final bool? success;
  final num? failCode;
  final String? message;

  RevertResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  RevertResponseModel copyWith({
    Data? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      RevertResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );

  factory RevertResponseModel.fromJson(Map<String, dynamic> json) =>
      RevertResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "failCode": failCode,
        "message": message,
      };
}

class Data {
  final String? message;

  Data({
    this.message,
  });

  Data copyWith({
    String? message,
  }) =>
      Data(
        message: message ?? this.message,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
