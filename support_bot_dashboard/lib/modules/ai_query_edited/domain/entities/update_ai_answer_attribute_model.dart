class UpdateAiAnswerAttributeModel {
  Data? data;
  bool? success;
  int? failCode;
  Params? params;
  String? message;

  UpdateAiAnswerAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.params,
    this.message,
  });
}

class Data {
  String? message;
  UpdatedAttributes? updatedAttributes;

  Data({
    this.message,
    this.updatedAttributes,
  });
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
}

class AgentAnsValidation {
  bool? agentAnsValidationBool;

  AgentAnsValidation({
    this.agentAnsValidationBool,
  });
}

class AiResponse {
  String? s;

  AiResponse({
    this.s,
  });
}

class Params {
  Params();
}
