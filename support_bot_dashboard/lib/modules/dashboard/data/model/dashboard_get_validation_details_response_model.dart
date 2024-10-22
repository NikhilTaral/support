// To parse this JSON data, do
//
//     final getValidationDetailsResponseModel = getValidationDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

GetValidationDetailsResponseModel getValidationDetailsResponseModelFromJson(String str) => GetValidationDetailsResponseModel.fromJson(json.decode(str));

String getValidationDetailsResponseModelToJson(GetValidationDetailsResponseModel data) => json.encode(data.toJson());

class GetValidationDetailsResponseModel {
    final Data? data;
    final bool? success;
    final int? failCode;
    final Params? params;
    final String? message;

    GetValidationDetailsResponseModel({
        this.data,
        this.success,
        this.failCode,
        this.params,
        this.message,
    });

    factory GetValidationDetailsResponseModel.fromJson(Map<String, dynamic> json) => GetValidationDetailsResponseModel(
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
    final String? message;
    final bool? status;

    Data({
        this.message,
        this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}
