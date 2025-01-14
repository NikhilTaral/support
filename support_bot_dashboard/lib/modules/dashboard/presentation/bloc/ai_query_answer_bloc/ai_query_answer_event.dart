part of 'ai_query_answer_bloc.dart';

abstract class AiQueryAnswerEvent {}

class AIQueryAnswerInitialEvent extends AiQueryAnswerEvent {
  final List<String>? selectedPipelineValue;
  final String? fieldName;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  AIQueryAnswerInitialEvent(
      {this.fieldName,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipelineValue});
}
