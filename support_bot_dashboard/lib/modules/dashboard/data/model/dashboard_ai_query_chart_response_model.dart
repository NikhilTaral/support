import 'dart:convert';

DashboardAiQueryChartResponseModel dashboardAiQueryChartResponseModelFromJson(String str) =>
    DashboardAiQueryChartResponseModel.fromJson(json.decode(str));

String dashboardAiQueryChartResponseModelToJson(DashboardAiQueryChartResponseModel data) =>
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

  factory DashboardAiQueryChartResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardAiQueryChartResponseModel(
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
  final num? aiQueryAnswer;
  final num? aiQueryNotAnswer;

  Data(
      {this.aiQueryAnswer,
      this.aiQueryNotAnswer});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      aiQueryAnswer: json["answered"],
      aiQueryNotAnswer: json["notAnswered"],);

  Map<String, dynamic> toJson() => {
        "answered": aiQueryAnswer,
        "notAnswered": aiQueryNotAnswer,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
