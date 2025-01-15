import 'dart:convert';

AiQueryResponseModel aiQueryResponseModelFromJson(String str) =>
    AiQueryResponseModel.fromJson(json.decode(str));

String aiQueryResponseModelToJson(AiQueryResponseModel data) =>
    json.encode(data.toJson());

class AiQueryResponseModel {
  AiQueryData? data;
  bool? success;
  num? failCode;
  Params? params;
  String? message;

  AiQueryResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  factory AiQueryResponseModel.fromJson(Map<String, dynamic> json) =>
      AiQueryResponseModel(
        data: json["data"] == null ? null : AiQueryData.fromJson(json["data"]),
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

class AiQueryData {
  num? totalRecords;
  List<AiQueryItem>? items;
  num? pageSize;
  LastEvaluatedKey? lastEvaluatedKey;
  num? currentPage;

  AiQueryData({
    this.totalRecords,
    this.items,
    this.pageSize,
    this.lastEvaluatedKey,
    this.currentPage,
  });

  factory AiQueryData.fromJson(Map<String, dynamic> json) => AiQueryData(
        totalRecords: json["totalRecords"],
        items: json["items"] == null
            ? []
            : List<AiQueryItem>.from(
                json["items"]!.map((x) => AiQueryItem.fromJson(x))),
        pageSize: json["pageSize"],
        lastEvaluatedKey: json["lastEvaluatedKey"] == null
            ? null
            : LastEvaluatedKey.fromJson(json["lastEvaluatedKey"]),
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "pageSize": pageSize,
        "lastEvaluatedKey": lastEvaluatedKey?.toJson(),
        "currentPage": currentPage,
      };
}

class AiQueryItem {
  String? id;
  String? createdAt;
  String? ticketDescription;
  String? aiResponse;
  bool? answeredStatus;
  bool? isAnswerEdited;
  bool? agentAnsValidation;
  String? answerValidationReason;

  AiQueryItem({
    this.id,
    this.createdAt,
    this.ticketDescription,
    this.aiResponse,
    this.answeredStatus,
    this.isAnswerEdited,
    this.agentAnsValidation,
    this.answerValidationReason,
  });

  factory AiQueryItem.fromJson(Map<String, dynamic> json) => AiQueryItem(
        id: json["id"],
        createdAt: json["CreatedAt"],
        ticketDescription: json["Ticket_Description"],
        aiResponse: json["AI_Response"],
        answeredStatus: json["answeredStatus"],
        isAnswerEdited: json["isAnswerEdited"],
        agentAnsValidation: json["agentAnsValidation"],
        answerValidationReason: json["answerValidationReason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "CreatedAt": createdAt,
        "Ticket_Description": ticketDescription,
        "AI_Response": aiResponse,
        "answeredStatus": answeredStatus,
        "isAnswerEdited": isAnswerEdited,
        "agentAnsValidation": agentAnsValidation,
        "answerValidationReason": answerValidationReason,
      };
}

class LastEvaluatedKey {
  CreatedAt? id;
  CreatedAt? dType;
  CreatedAt? createdAt;

  LastEvaluatedKey({
    this.id,
    this.dType,
    this.createdAt,
  });

  factory LastEvaluatedKey.fromJson(Map<String, dynamic> json) =>
      LastEvaluatedKey(
        id: json["id"] == null ? null : CreatedAt.fromJson(json["id"]),
        dType: json["dType"] == null ? null : CreatedAt.fromJson(json["dType"]),
        createdAt: json["CreatedAt"] == null
            ? null
            : CreatedAt.fromJson(json["CreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id?.toJson(),
        "dType": dType?.toJson(),
        "CreatedAt": createdAt?.toJson(),
      };
}

class CreatedAt {
  String? s;

  CreatedAt({
    this.s,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
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
