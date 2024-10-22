// To parse this JSON data, do
//
//     final getValidationByCountResponseModel = getValidationByCountResponseModelFromJson(jsonString);

import 'dart:convert';

GetValidationByCountResponseModel getValidationByCountResponseModelFromJson(String str) => GetValidationByCountResponseModel.fromJson(json.decode(str));

String getValidationByCountResponseModelToJson(GetValidationByCountResponseModel data) => json.encode(data.toJson());

class GetValidationByCountResponseModel {
    final Data? data;
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
    final int? agent1;
    final int? agent2;
    final int? agent3;

    Data({
        this.agent1,
        this.agent2,
        this.agent3,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        agent1: json["agent1"],
        agent2: json["agent2"],
        agent3: json["agent3"],
    );

    Map<String, dynamic> toJson() => {
        "agent1": agent1,
        "agent2": agent2,
        "agent3": agent3,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}
