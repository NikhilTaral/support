// To parse this JSON data, do
//
//     final getValidationByCountResponseModel = getValidationByCountResponseModelFromJson(jsonString);

import 'dart:convert';

GetValidationByCountResponseModel getValidationByCountResponseModelFromJson(
        String str) =>
    GetValidationByCountResponseModel.fromJson(json.decode(str));

String getValidationByCountResponseModelToJson(
        GetValidationByCountResponseModel data) =>
    json.encode(data.toJson());

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

  factory GetValidationByCountResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetValidationByCountResponseModel(
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
  final Map<String, double>? counts;
  final Map<String, double>? percentages;

  Data({
    this.counts,
    this.percentages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        counts: Map.from(json["counts"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        percentages: Map.from(json["percentages"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "counts":
            Map.from(counts!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "percentages": Map.from(percentages!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
