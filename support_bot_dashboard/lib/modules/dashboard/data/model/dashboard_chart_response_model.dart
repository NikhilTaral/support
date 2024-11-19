// To parse this JSON data, do
//
//     final dashboardChartResponseModel = dashboardChartResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardChartResponseModel dashboardChartResponseModelFromJson(String str) =>
    DashboardChartResponseModel.fromJson(json.decode(str));

String dashboardChartResponseModelToJson(DashboardChartResponseModel data) =>
    json.encode(data.toJson());

class DashboardChartResponseModel {
  final Data? data;
  final bool? success;
  final int? failCode;
  final Params? params;
  final String? message;

  DashboardChartResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  factory DashboardChartResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardChartResponseModel(
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
  final double? genuineQuery;
  final double? noActionRequired;
  final double? spamMarketing;
  final double? acknowledgementRequired;
  final double? notClassified;

  Counts({
    this.genuineQuery,
    this.noActionRequired,
    this.spamMarketing,
    this.acknowledgementRequired,
    this.notClassified,
  });

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
        genuineQuery: json["Genuine Query"]?.toDouble(),
        noActionRequired: json["No Action Required"]?.toDouble(),
        spamMarketing: json["Spam/Marketing"]?.toDouble(),
        acknowledgementRequired: json["Acknowledgement Required"]?.toDouble(),
        notClassified: json["Not Classified"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Genuine Query": genuineQuery,
        "No Action Required": noActionRequired,
        "Spam/Marketing": spamMarketing,
        "Acknowledgement Required": acknowledgementRequired,
        "Not Classified": notClassified,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
