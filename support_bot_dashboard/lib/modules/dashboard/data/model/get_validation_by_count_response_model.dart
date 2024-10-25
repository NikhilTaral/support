// To parse this JSON data, do
//
//     final getValidationByCountResponseModel = getValidationByCountResponseModelFromJson(jsonString);

import 'dart:convert';

GetValidationByCountResponseModel getValidationByCountResponseModelFromJson(String str) => GetValidationByCountResponseModel.fromJson(json.decode(str));

String getValidationByCountResponseModelToJson(GetValidationByCountResponseModel data) => json.encode(data.toJson());

class GetValidationByCountResponseModel {
    final Map<String, int>? data;
    final bool? success;
    final int? failCode;
    final Params? params;
    final String? message;

    GetValidationByCountResponseModel({
        this.data,
        this.success,
        this.failCode,
        this.params,
        this.message,
    });

    factory GetValidationByCountResponseModel.fromJson(Map<String, dynamic> json) => GetValidationByCountResponseModel(
        data: Map.from(json["data"]!).map((k, v) => MapEntry<String, int>(k, v)),
        success: json["success"],
        failCode: json["failCode"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "success": success,
        "failCode": failCode,
        "params": params?.toJson(),
        "message": message,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}
