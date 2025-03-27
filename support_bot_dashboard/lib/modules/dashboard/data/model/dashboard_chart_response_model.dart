import 'dart:convert';

DashboardAnswerResponseModel dashboardAnswerResponseModelFromJson(String str) =>
    DashboardAnswerResponseModel.fromJson(json.decode(str));

String dashboardAnswerResponseModelToJson(DashboardAnswerResponseModel data) =>
    json.encode(data.toJson());

class DashboardAnswerResponseModel {
  final Data? data;
  final bool? success;
  final num? failCode;
  final String? message;

  DashboardAnswerResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  factory DashboardAnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardAnswerResponseModel(
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
  final num? unableToClassify;
  final double? awaitingToClassify;
  final num? total;

  Counts({
    this.genuineQuery,
    this.noActionRequired,
    this.spamMarketing,
    this.acknowledgementRequired,
    this.unableToClassify,
    this.awaitingToClassify,
    this.total,
  });

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
        genuineQuery: json["Genuine Query"]?.toDouble(),
        noActionRequired: json["No Action Required"]?.toDouble(),
        spamMarketing: json["Spam/Marketing"]?.toDouble(),
        acknowledgementRequired: json["Acknowledgement Required"]?.toDouble(),
        unableToClassify: json["Unable to Classify"],
        awaitingToClassify: json["Awaiting to Classify"]?.toDouble(),
        total: json["Total"],
      );

  Map<String, dynamic> toJson() => {
        "Genuine Query": genuineQuery,
        "No Action Required": noActionRequired,
        "Spam/Marketing": spamMarketing,
        "Acknowledgement Required": acknowledgementRequired,
        "Unable to Classify": unableToClassify,
        "Awaiting to Classify": awaitingToClassify,
        "Total": total,
      };
}
