import 'dart:convert';

class GetAllPipelinesAttributeModel {
  final List<GetAllPipelineData>? data;
  final bool? success;
  final num? failCode;
  final Params? params;
  final String? message;

  GetAllPipelinesAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  GetAllPipelinesAttributeModel copyWith({
    List<GetAllPipelineData>? data,
    bool? success,
    num? failCode,
    Params? params,
    String? message,
  }) =>
      GetAllPipelinesAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        params: params ?? this.params,
        message: message ?? this.message,
      );
}

class GetAllPipelineData {
  final String? pipelineId;
  final String? pipelineName;
  final bool? hubspotUpdatepPerm;
  final bool? aiAnswerPerm;
  final String? hubspotUpdateEnv;

  GetAllPipelineData({
    this.pipelineId,
    this.pipelineName,
    this.hubspotUpdatepPerm,
    this.aiAnswerPerm,
    this.hubspotUpdateEnv,
  });

  GetAllPipelineData copyWith({
    String? pipelineId,
    String? pipelineName,
    bool? hubspotUpdatepPerm,
    bool? aiAnswerPerm,
    String? hubspotUpdateEnv,
  }) =>
      GetAllPipelineData(
        pipelineId: pipelineId ?? this.pipelineId,
        pipelineName: pipelineName ?? this.pipelineName,
        hubspotUpdatepPerm: hubspotUpdatepPerm ?? this.hubspotUpdatepPerm,
        aiAnswerPerm: aiAnswerPerm ?? this.aiAnswerPerm,
        hubspotUpdateEnv: hubspotUpdateEnv ?? this.hubspotUpdateEnv,
      );

  toLowerCase() {}
}

class Params {
  Params();

  factory Params.fromRawJson(String str) => Params.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
