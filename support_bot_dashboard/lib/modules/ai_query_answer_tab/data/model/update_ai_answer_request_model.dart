class UpdateAiAnswerRequestModel {
  String? ticketId;
  String? newAnswer;
  String? pipeline;

  UpdateAiAnswerRequestModel({
    this.ticketId,
    this.newAnswer,
    this.pipeline,
  });

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "newAnswer": newAnswer,
        "pipeline": pipeline,
      };
}
