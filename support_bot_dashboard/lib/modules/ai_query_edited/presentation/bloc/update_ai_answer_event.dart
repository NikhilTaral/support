part of 'update_ai_answer_bloc.dart';

abstract class UpdateAiAnswerEvent {}

class UpdateAiAnswerInitialEvent extends UpdateAiAnswerEvent {
  final String? ticketId;
  final String? updatedAnswer;
  final String? selectedPipelineValue;

  UpdateAiAnswerInitialEvent(
      {this.ticketId, this.updatedAnswer, this.selectedPipelineValue});
}
