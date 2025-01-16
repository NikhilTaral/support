class AddAnswerValidationRequestModel {
  String? ticketId;
  bool? agentAnsValidation;
  String? pipeline;

  AddAnswerValidationRequestModel({
    this.ticketId,
    this.agentAnsValidation,
    this.pipeline,
  });

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "agentAnsValidation": agentAnsValidation,
        "pipeline": pipeline,
      };
}
