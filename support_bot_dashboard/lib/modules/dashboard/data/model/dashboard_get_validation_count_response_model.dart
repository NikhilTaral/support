// To parse this JSON data, do
//
//     final getValidationCountResponseModel = getValidationCountResponseModelFromJson(jsonString);

import 'dart:convert';

GetValidationCountResponseModel getValidationCountResponseModelFromJson(String str) => GetValidationCountResponseModel.fromJson(json.decode(str));

String getValidationCountResponseModelToJson(GetValidationCountResponseModel data) => json.encode(data.toJson());

class GetValidationCountResponseModel {
    final Data? data;
    final bool? success;
    final num? failCode;
    final Params? params;
    final String? message;

    GetValidationCountResponseModel({
        this.data,
        this.success,
        this.failCode,
        this.params,
        this.message,
    });

    factory GetValidationCountResponseModel.fromJson(Map<String, dynamic> json) => GetValidationCountResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "failCode": failCode,
        "params": params?.toJson(),
        "message": message,
    };
}

class Data {
    final num? correct;
    final num? incorrect;
    final num? notValidated;

    Data({
        this.correct,
        this.incorrect,
        this.notValidated,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        correct: json["correct"],
        incorrect: json["incorrect"],
        notValidated: json["notValidated"],
    );

    Map<String, dynamic> toJson() => {
        "correct": correct,
        "incorrect": incorrect,
        "notValidated": notValidated,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}
