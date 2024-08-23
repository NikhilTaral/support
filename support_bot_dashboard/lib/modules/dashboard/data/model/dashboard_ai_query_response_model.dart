class DashboardAiQueryResponseModel {
  final Data? data;
  final bool? success;
  final int? failCode;
  final Params? params;
  final String? message;

  DashboardAiQueryResponseModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });

  DashboardAiQueryResponseModel.fromJson(Map<String, dynamic> json)
    : data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null,
      success = json['success'] as bool?,
      failCode = json['failCode'] as int?,
      params = (json['params'] as Map<String,dynamic>?) != null ? Params.fromJson(json['params'] as Map<String,dynamic>) : null,
      message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'data' : data?.toJson(),
    'success' : success,
    'failCode' : failCode,
    'params' : params?.toJson(),
    'message' : message
  };
}

class Data {
  final int? totalRecords;
  final List<Items>? items;
  final String? lastEvaluatedKey;

  Data({
    this.totalRecords,
    this.items,
    this.lastEvaluatedKey,
  });

  Data.fromJson(Map<String, dynamic> json)
    : totalRecords = json['totalRecords'] as int?,
      items = (json['items'] as List?)?.map((dynamic e) => Items.fromJson(e as Map<String,dynamic>)).toList(),
      lastEvaluatedKey = json['lastEvaluatedKey'] as String?;

  Map<String, dynamic> toJson() => {
    'totalRecords' : totalRecords,
    'items' : items?.map((e) => e.toJson()).toList(),
    'lastEvaluatedKey' : lastEvaluatedKey
  };
}

class Items {
  final String? id;
  final String? createdAt;
  final String? ticketDescription;
  final String? aIResponse;
  final bool? isAnswerEdited;
  final bool? answerValidation;
  final String? answerValidationReason;

  Items({
    this.id,
    this.createdAt,
    this.ticketDescription,
    this.aIResponse,
    this.isAnswerEdited,
    this.answerValidation,
    this.answerValidationReason,
  });

  Items.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      createdAt = json['CreatedAt'] as String?,
      ticketDescription = json['Ticket_Description'] as String?,
      aIResponse = json['AI_Response'] as String?,
      isAnswerEdited = json['isAnswerEdited'] as bool?,
      answerValidation = json['answerValidation'] as bool?,
      answerValidationReason = json['answerValidationReason'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'CreatedAt' : createdAt,
    'Ticket_Description' : ticketDescription,
    'AI_Response' : aIResponse,
    'isAnswerEdited' : isAnswerEdited,
    'answerValidation' : answerValidation,
    'answerValidationReason' : answerValidationReason
  };
}
class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}