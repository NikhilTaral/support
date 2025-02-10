part of 'add_answer_validation_bloc.dart';

abstract class AddAnswerValidationEvent {}

class AddAnswerValidationInitialEvent extends AddAnswerValidationEvent {
  final String? ticketId;
  final String? pipeline;
  final bool? agentAnsValidation;

  AddAnswerValidationInitialEvent(
      {this.ticketId, this.pipeline, this.agentAnsValidation});
}
