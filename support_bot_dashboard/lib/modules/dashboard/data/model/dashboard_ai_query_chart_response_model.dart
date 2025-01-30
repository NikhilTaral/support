// To parse this JSON data, do
//
//     final dashboardAiQueryChartResponseModel = dashboardAiQueryChartResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardAiQueryChartResponseModel dashboardAiQueryChartResponseModelFromJson(
        String jsonString) =>
    DashboardAiQueryChartResponseModel.fromJson(json.decode(jsonString));

String dashboardAiQueryChartResponseModelToJson(
        DashboardAiQueryChartResponseModel data) =>
    json.encode(data.toJson());

class DashboardAiQueryChartResponseModel {
  final Data? data;
  final bool? success;
  final num? failCode;
  final Params? params;
  final String? message;

  DashboardAiQueryChartResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  factory DashboardAiQueryChartResponseModel.fromJson(
          Map<String, dynamic> json) =>
      DashboardAiQueryChartResponseModel(
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
  final Counts? counts;
  final Counts? percentages;

  Data({
    this.counts,
    this.percentages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        counts: json["counts"] == null ? null : Counts.fromJson(json["counts"]),
        percentages: json["percentages"] == null
            ? null
            : Counts.fromJson(json["percentages"]),
      );

  Map<String, dynamic> toJson() => {
        "counts": counts?.toJson(),
        "percentages": percentages?.toJson(),
      };
}

class Counts {
  final double? answeredCount;
  final double? notAnsweredCount;

  Counts({
    this.answeredCount,
    this.notAnsweredCount,
  });

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
        answeredCount: json["answeredCount"],
        notAnsweredCount: json["notAnsweredCount"],
      );

  Map<String, dynamic> toJson() => {
        "answeredCount": answeredCount,
        "notAnsweredCount": notAnsweredCount,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
