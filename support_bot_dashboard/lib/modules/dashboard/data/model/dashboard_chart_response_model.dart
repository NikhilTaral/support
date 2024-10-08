import 'dart:convert';

DashboardChartResponseModel dashboardChartResponseModelFromJson(String str) =>
    DashboardChartResponseModel.fromJson(json.decode(str));

String dashboardChartResponseModelToJson(DashboardChartResponseModel data) =>
    json.encode(data.toJson());

class DashboardChartResponseModel {
  final Data? data;
  final bool? success;
  final num? failCode;
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
        data: Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        params: Params.fromJson(json["params"]),
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
  final num? genuineQuery;
  final num? noActionRequired;
  final num? spamMarketing;
  final num? acknowledgement;
  final num? notClassified;

  Data(
      {this.genuineQuery,
      this.noActionRequired,
      this.spamMarketing,
      this.acknowledgement,
      this.notClassified
      });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      genuineQuery: json["Genuine Query"],
      noActionRequired: json["No Action Required"],
      spamMarketing: json["Spam/Marketing"],
      acknowledgement: json['Acknowledgement Required'],
      notClassified: json['Not Classified']
      );

  Map<String, dynamic> toJson() => {
        "Genuine Query": genuineQuery,
        "No Action Required": noActionRequired,
        "Spam/Marketing": spamMarketing,
        "Acknowledgement Required": acknowledgement,
        "Not Classified": notClassified
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
