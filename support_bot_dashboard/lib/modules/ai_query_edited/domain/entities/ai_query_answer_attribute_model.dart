class AiQueryAttributeModel {
  AiQueryAttributeData? data;
  bool? success;
  num? failCode;
  Params? params;
  String? message;

  AiQueryAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });
}

class AiQueryAttributeData {
  num? totalRecords;
  List<AiQueryAttributeItem>? items;
  num? pageSize;
  LastEvaluatedKey? lastEvaluatedKey;
  num? currentPage;

  AiQueryAttributeData({
    this.totalRecords,
    this.items,
    this.pageSize,
    this.lastEvaluatedKey,
    this.currentPage,
  });
}

class AiQueryAttributeItem {
  String? id;
  String? createdAt;
  String? ticketDescription;
  String? aiResponse;
  String? answeredStatus;
  bool? isAnswerEdited;
  bool? agentAnsValidation;
  String? answerValidationReason;

  AiQueryAttributeItem({
    this.id,
    this.createdAt,
    this.ticketDescription,
    this.aiResponse,
    this.answeredStatus,
    this.isAnswerEdited,
    this.agentAnsValidation,
    this.answerValidationReason,
  });
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
}

class CreatedAt {
  String? s;

  CreatedAt({
    this.s,
  });
}

class Params {
  Params();
}
