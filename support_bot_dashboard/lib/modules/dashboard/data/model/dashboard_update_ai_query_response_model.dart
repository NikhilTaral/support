import 'dart:convert';

DashboardUpdateAiQueryResponseModel dashboardUpdateAiQueryResponseModelFromJson(
        String str) =>
    DashboardUpdateAiQueryResponseModel.fromJson(json.decode(str));

String dashboardUpdateAiQueryResponseModelToJson(
        DashboardUpdateAiQueryResponseModel data) =>
    json.encode(data.toJson());

class DashboardUpdateAiQueryResponseModel {
  final Data data;
  final bool success;
  final num failCode;
  final Params params;
  final String message;

  DashboardUpdateAiQueryResponseModel({
    required this.data,
    required this.success,
    required this.failCode,
    required this.params,
    required this.message,
  });

  factory DashboardUpdateAiQueryResponseModel.fromJson(
          Map<String, dynamic> json) =>
      DashboardUpdateAiQueryResponseModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        failCode: json["failCode"],
        params: Params.fromJson(json["params"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "failCode": failCode,
        "params": params.toJson(),
        "message": message,
      };
}

class Data {
  final String message;
  final UpdatedAttributes updatedAttributes;

  Data({
    required this.message,
    required this.updatedAttributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        updatedAttributes:
            UpdatedAttributes.fromJson(json["updatedAttributes"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "updatedAttributes": updatedAttributes.toJson(),
      };
}

class UpdatedAttributes {
  final bool isAnswerEdited;
  final String aiResponse;

  UpdatedAttributes({
    required this.isAnswerEdited,
    required this.aiResponse,
  });

  factory UpdatedAttributes.fromJson(Map<String, dynamic> json) =>
      UpdatedAttributes(
        isAnswerEdited: json["isAnswerEdited"],
        aiResponse: json["AI_Response"],
      );

  Map<String, dynamic> toJson() => {
        "isAnswerEdited": isAnswerEdited,
        "AI_Response": aiResponse,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
