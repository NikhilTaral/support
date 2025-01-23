part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerEvent {}

class AIQueryAnswerInitialEvent extends AiQueryAnswerEvent {
  final List<String>? selectedPipelineValue;
  final String? fieldName;
  final DateTime? startDate;
  final DateTime? endDate;
  AIQueryAnswerInitialEvent(
      {this.fieldName,
      this.startDate,
      this.endDate,
      this.selectedPipelineValue});
}
