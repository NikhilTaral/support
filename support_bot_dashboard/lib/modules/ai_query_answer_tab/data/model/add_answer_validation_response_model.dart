import 'dart:convert';

AddAnswerValidationResponseModel addAnswerValidationResponseModelFromJson(
        String str) =>
    AddAnswerValidationResponseModel.fromJson(json.decode(str));

String addAnswerValidationResponseModelToJson(
        AddAnswerValidationResponseModel data) =>
    json.encode(data.toJson());

class AddAnswerValidationResponseModel {
  String? ticketId;
  bool? agentAnsValidation;
  String? pipeline;

  AddAnswerValidationResponseModel({
    this.ticketId,
    this.agentAnsValidation,
    this.pipeline,
  });

  factory AddAnswerValidationResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AddAnswerValidationResponseModel(
        ticketId: json["ticketId"],
        agentAnsValidation: json["agentAnsValidation"],
        pipeline: json["pipeline"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "agentAnsValidation": agentAnsValidation,
        "pipeline": pipeline,
      };
}
