part of 'ai_query_Edited_answer_bloc.dart';

abstract class AiQueryEditedAnswerEvent {}

class AIQueryEditedAnswerCallEvent extends AiQueryEditedAnswerEvent {
  final String? selectedPipelineValue;
  final String? fildName;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  AIQueryEditedAnswerCallEvent(
      {this.fildName,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipelineValue});
}
