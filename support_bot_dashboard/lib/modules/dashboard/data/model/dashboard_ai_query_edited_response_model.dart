// To parse this JSON data, do
//
//     final dashboardAiQueryEditedResponseModel = dashboardAiQueryEditedResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardAiQueryEditedResponseModel dashboardAiQueryEditedResponseModelFromJson(
        String str) =>
    DashboardAiQueryEditedResponseModel.fromJson(json.decode(str));

String dashboardAiQueryEditedResponseModelToJson(
        DashboardAiQueryEditedResponseModel data) =>
    json.encode(data.toJson());

class DashboardAiQueryEditedResponseModel {
  AIQueryEditedData? data;
  bool? success;
  int? failCode;
  Params? params;
  String? message;

  DashboardAiQueryEditedResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  factory DashboardAiQueryEditedResponseModel.fromJson(
          Map<String, dynamic> json) =>
      DashboardAiQueryEditedResponseModel(
        data: json["data"] == null
            ? null
            : AIQueryEditedData.fromJson(json["data"]),
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

class AIQueryEditedData {
  AIQueryEditedCounts? counts;
  AIQueryEditedCounts? percentages;

  AIQueryEditedData({
    this.counts,
    this.percentages,
  });

  factory AIQueryEditedData.fromJson(Map<String, dynamic> json) =>
      AIQueryEditedData(
        counts: json["counts"] == null
            ? null
            : AIQueryEditedCounts.fromJson(json["counts"]),
        percentages: json["percentages"] == null
            ? null
            : AIQueryEditedCounts.fromJson(json["percentages"]),
      );

  Map<String, dynamic> toJson() => {
        "counts": counts?.toJson(),
        "percentages": percentages?.toJson(),
      };
}

class AIQueryEditedCounts {
  num? editedCount;
  num? unEditedCount;

  AIQueryEditedCounts({
    this.editedCount,
    this.unEditedCount,
  });

  factory AIQueryEditedCounts.fromJson(Map<String, dynamic> json) =>
      AIQueryEditedCounts(
        editedCount: json["editedCount"],
        unEditedCount: json["unEditedCount"],
      );

  Map<String, dynamic> toJson() => {
        "editedCount": editedCount,
        "unEditedCount": unEditedCount,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
