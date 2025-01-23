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

  AiQueryAttributeModel copyWith({
    AiQueryAttributeData? data,
    bool? success,
    num? failCode,
    Params? params,
    String? message,
  }) {
    return AiQueryAttributeModel(
      data: data ?? this.data,
      success: success ?? this.success,
      failCode: failCode ?? this.failCode,
      params: params ?? this.params,
      message: message ?? this.message,
    );
  }
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

  AiQueryAttributeData copyWith({
    num? totalRecords,
    List<AiQueryAttributeItem>? items,
    num? pageSize,
    LastEvaluatedKey? lastEvaluatedKey,
    num? currentPage,
  }) {
    return AiQueryAttributeData(
      totalRecords: totalRecords ?? this.totalRecords,
      items: items ?? this.items,
      pageSize: pageSize ?? this.pageSize,
      lastEvaluatedKey: lastEvaluatedKey ?? this.lastEvaluatedKey,
      currentPage: currentPage ?? this.currentPage,
    );
  }
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

  AiQueryAttributeItem copyWith({
    String? id,
    String? createdAt,
    String? ticketDescription,
    String? aiResponse,
    String? answeredStatus,
    bool? isAnswerEdited,
    bool? agentAnsValidation,
    String? answerValidationReason,
  }) {
    return AiQueryAttributeItem(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      ticketDescription: ticketDescription ?? this.ticketDescription,
      aiResponse: aiResponse ?? this.aiResponse,
      answeredStatus: answeredStatus ?? this.answeredStatus,
      isAnswerEdited: isAnswerEdited ?? this.isAnswerEdited,
      agentAnsValidation: agentAnsValidation ?? this.agentAnsValidation,
      answerValidationReason: answerValidationReason ?? this.answerValidationReason,
    );
  }
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

  LastEvaluatedKey copyWith({
    CreatedAt? id,
    CreatedAt? dType,
    CreatedAt? createdAt,
  }) {
    return LastEvaluatedKey(
      id: id ?? this.id,
      dType: dType ?? this.dType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CreatedAt {
  String? s;

  CreatedAt({
    this.s,
  });

  CreatedAt copyWith({
    String? s,
  }) {
    return CreatedAt(
      s: s ?? this.s,
    );
  }
}

class Params {
  Params();

  Params copyWith() {
    return Params();
  }
}
