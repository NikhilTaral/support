import 'dart:convert';

UpdateAiAnswerResponseModel updateAiAnswerResponseModelFromJson(String str) =>
    UpdateAiAnswerResponseModel.fromJson(json.decode(str));

String updateAiAnswerResponseModelToJson(UpdateAiAnswerResponseModel data) =>
    json.encode(data.toJson());

class UpdateAiAnswerResponseModel {
  Data? data;
  bool? success;
  int? failCode;
  Params? params;
  String? message;

  UpdateAiAnswerResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  factory UpdateAiAnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateAiAnswerResponseModel(
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
  String? message;
  UpdatedAttributes? updatedAttributes;

  Data({
    this.message,
    this.updatedAttributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        updatedAttributes: json["updatedAttributes"] == null
            ? null
            : UpdatedAttributes.fromJson(json["updatedAttributes"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "updatedAttributes": updatedAttributes?.toJson(),
      };
}

class UpdatedAttributes {
  AgentAnsValidation? isAnswerEdited;
  AiResponse? aiResponse;
  AgentAnsValidation? agentAnsValidation;

  UpdatedAttributes({
    this.isAnswerEdited,
    this.aiResponse,
    this.agentAnsValidation,
  });

  factory UpdatedAttributes.fromJson(Map<String, dynamic> json) =>
      UpdatedAttributes(
        isAnswerEdited: json["isAnswerEdited"] == null
            ? null
            : AgentAnsValidation.fromJson(json["isAnswerEdited"]),
        aiResponse: json["AI_Response"] == null
            ? null
            : AiResponse.fromJson(json["AI_Response"]),
        agentAnsValidation: json["agentAnsValidation"] == null
            ? null
            : AgentAnsValidation.fromJson(json["agentAnsValidation"]),
      );

  Map<String, dynamic> toJson() => {
        "isAnswerEdited": isAnswerEdited?.toJson(),
        "AI_Response": aiResponse?.toJson(),
        "agentAnsValidation": agentAnsValidation?.toJson(),
      };
}

class AgentAnsValidation {
  bool? agentAnsValidationBool;

  AgentAnsValidation({
    this.agentAnsValidationBool,
  });

  factory AgentAnsValidation.fromJson(Map<String, dynamic> json) =>
      AgentAnsValidation(
        agentAnsValidationBool: json["BOOL"],
      );

  Map<String, dynamic> toJson() => {
        "BOOL": agentAnsValidationBool,
      };
}

class AiResponse {
  String? s;

  AiResponse({
    this.s,
  });

  factory AiResponse.fromJson(Map<String, dynamic> json) => AiResponse(
        s: json["S"],
      );

  Map<String, dynamic> toJson() => {
        "S": s,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
