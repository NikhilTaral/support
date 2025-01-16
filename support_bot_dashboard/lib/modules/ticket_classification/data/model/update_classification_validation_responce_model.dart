// To parse this JSON data, do
//
//     final updateClassificationValidationResponseModel = updateClassificationValidationResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateClassificationValidationResponseModel updateClassificationValidationResponseModelFromJson(String str) => UpdateClassificationValidationResponseModel.fromJson(json.decode(str));

String updateClassificationValidationResponseModelToJson(UpdateClassificationValidationResponseModel data) => json.encode(data.toJson());

class UpdateClassificationValidationResponseModel {
    final Data? data;
    final bool? success;
    final int? failCode;
    final String? message;

    UpdateClassificationValidationResponseModel({
        this.data,
        this.success,
        this.failCode,
        this.message,
    });

    UpdateClassificationValidationResponseModel copyWith({
        Data? data,
        bool? success,
        int? failCode,
        String? message,
    }) => 
        UpdateClassificationValidationResponseModel(
            data: data ?? this.data,
            success: success ?? this.success,
            failCode: failCode ?? this.failCode,
            message: message ?? this.message,
        );

    factory UpdateClassificationValidationResponseModel.fromJson(Map<String, dynamic> json) => UpdateClassificationValidationResponseModel(
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
