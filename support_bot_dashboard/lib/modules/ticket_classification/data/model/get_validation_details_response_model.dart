// To parse this JSON data, do
//
//     final getValidationDetailsResponsrModel = getValidationDetailsResponsrModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetValidationDetailsResponsrModel getValidationDetailsResponsrModelFromJson(String str) => GetValidationDetailsResponsrModel.fromJson(json.decode(str));

String getValidationDetailsResponsrModelToJson(GetValidationDetailsResponsrModel data) => json.encode(data.toJson());

class GetValidationDetailsResponsrModel {
    final Data data;
    final bool success;
    final int failCode;
    final String message;

    GetValidationDetailsResponsrModel({
        required this.data,
        required this.success,
        required this.failCode,
        required this.message,
    });

    GetValidationDetailsResponsrModel copyWith({
        Data? data,
        bool? success,
        int? failCode,
        String? message,
    }) => 
        GetValidationDetailsResponsrModel(
            data: data ?? this.data,
            success: success ?? this.success,
            failCode: failCode ?? this.failCode,
            message: message ?? this.message,
        );

    factory GetValidationDetailsResponsrModel.fromJson(Map<String, dynamic> json) => GetValidationDetailsResponsrModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "failCode": failCode,
        "message": message,
    };
}

class Data {
    final String message;
    final bool status;

    Data({
        required this.message,
        required this.status,
    });

    Data copyWith({
        String? message,
        bool? status,
    }) => 
        Data(
            message: message ?? this.message,
            status: status ?? this.status,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
