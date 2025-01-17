import 'dart:convert';

class UpdateClassificationValidationRequestModel {
  final String? id;

  final String? validation;
  final String? reason;
  final String? validatedClassification;
  final String? pipeline;

  UpdateClassificationValidationRequestModel({
    this.id,
    this.validation,
    this.reason,
    this.validatedClassification,
    this.pipeline,
  });

  UpdateClassificationValidationRequestModel copyWith({
    String? id,
    String? validation,
    String? reason,
    String? validatedClassification,
    String? pipeline,
  }) =>
      UpdateClassificationValidationRequestModel(
        id: id ?? this.id,
        validation: validation ?? this.validation,
        reason: reason ?? this.reason,
        validatedClassification:
            validatedClassification ?? this.validatedClassification,
        pipeline: pipeline ?? this.pipeline,
      );

  factory UpdateClassificationValidationRequestModel.fromRawJson(String str) =>
      UpdateClassificationValidationRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateClassificationValidationRequestModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateClassificationValidationRequestModel(
        id: json["id"],
        validation: json["validation"],
        reason: json["reason"],
        validatedClassification: json["validatedClassification"],
        pipeline: json["pipeline"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "validation": validation,
        "reason": reason,
        "validatedClassification": validatedClassification,
        "pipeline": pipeline,
      };
}
