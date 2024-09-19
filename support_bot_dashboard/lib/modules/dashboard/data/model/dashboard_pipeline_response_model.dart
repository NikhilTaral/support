import 'dart:convert';

DashboardPipelineResponseModel dashboardPipelineResponseModelFromJson(
        String str) =>
    DashboardPipelineResponseModel.fromJson(json.decode(str));

String dashboardPipelineResponseModelToJson(
        DashboardPipelineResponseModel data) =>
    json.encode(data.toJson());

class DashboardPipelineResponseModel {
  final List<Datum> data;
  final bool success;
  final int failCode;
  final Params params;
  final String message;

  DashboardPipelineResponseModel({
    required this.data,
    required this.success,
    required this.failCode,
    required this.params,
    required this.message,
  });

  factory DashboardPipelineResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardPipelineResponseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
        failCode: json["failCode"],
        params: Params.fromJson(json["params"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "failCode": failCode,
        "params": params.toJson(),
        "message": message,
      };
}

class Datum {
  final String pipelineId;
  final String pipelineName;
  final bool? hubspotUpdatepPerm;
  final bool? aiAnswerPerm;
  final String? hubspotUpdateEnv;

  Datum(
      {required this.pipelineId,
      required this.pipelineName,
      this.aiAnswerPerm,
      this.hubspotUpdateEnv,
      this.hubspotUpdatepPerm});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pipelineId: json["PipelineId"],
        pipelineName: json["PipelineName"],
        hubspotUpdatepPerm: json["hubspotUpdatepPerm"],
        aiAnswerPerm: json["AIAnswerPerm"],
        hubspotUpdateEnv: json["hubspotUpdateEnv"],
      );

  Map<String, dynamic> toJson() => {
        "PipelineId": pipelineId,
        "PipelineName": pipelineName,
        "hubspotUpdatepPerm": hubspotUpdatepPerm,
        "AIAnswerPerm": aiAnswerPerm,
        "hubspotUpdateEnv": hubspotUpdateEnv,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
