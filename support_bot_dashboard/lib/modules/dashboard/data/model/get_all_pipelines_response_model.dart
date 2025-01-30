import 'dart:convert';

GetAllPipelinesResponsetModel getAllPipelinesFromJson(String str) =>
    GetAllPipelinesResponsetModel.fromJson(json.decode(str));

String getAllPipelinesToJson(GetAllPipelinesResponsetModel data) =>
    json.encode(data.toJson());

class GetAllPipelinesResponsetModel {
  final List<Datum>? data;
  final bool? success;
  final num? failCode;
  final Params? params;
  final String? message;

  GetAllPipelinesResponsetModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  GetAllPipelinesResponsetModel copyWith({
    List<Datum>? data,
    bool? success,
    num? failCode,
    Params? params,
    String? message,
  }) =>
      GetAllPipelinesResponsetModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        params: params ?? this.params,
        message: message ?? this.message,
      );

  factory GetAllPipelinesResponsetModel.fromJson(Map<String, dynamic> json) =>
      GetAllPipelinesResponsetModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        success: json["success"],
        failCode: json["failCode"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "failCode": failCode,
        "params": params?.toJson(),
        "message": message,
      };
}

class Datum {
  final String? pipelineId;
  final String? pipelineName;
  final bool? hubspotUpdatepPerm;
  final bool? aiAnswerPerm;
  final String? hubspotUpdateEnv;

  Datum({
    this.pipelineId,
    this.pipelineName,
    this.hubspotUpdatepPerm,
    this.aiAnswerPerm,
    this.hubspotUpdateEnv,
  });

  Datum copyWith({
    String? pipelineId,
    String? pipelineName,
    bool? hubspotUpdatepPerm,
    bool? aiAnswerPerm,
    String? hubspotUpdateEnv,
  }) =>
      Datum(
        pipelineId: pipelineId ?? this.pipelineId,
        pipelineName: pipelineName ?? this.pipelineName,
        hubspotUpdatepPerm: hubspotUpdatepPerm ?? this.hubspotUpdatepPerm,
        aiAnswerPerm: aiAnswerPerm ?? this.aiAnswerPerm,
        hubspotUpdateEnv: hubspotUpdateEnv ?? this.hubspotUpdateEnv,
      );

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
