part of 'update_classification_validation_bloc.dart';

abstract class UpdateClassificationValidationEvent {}

class UpdateClassificationValidationstateEvent
    extends UpdateClassificationValidationEvent {
  final String? id;
  final String? pipeline;
  final String? reason;
  final String? validatedClassification;
  final String? validation;
  UpdateClassificationValidationstateEvent(
      {this.id,
      this.pipeline,
      this.reason,
      this.validatedClassification,
      this.validation});
}
