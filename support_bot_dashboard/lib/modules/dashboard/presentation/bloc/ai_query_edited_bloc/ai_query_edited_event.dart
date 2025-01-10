part of 'ai_query_edited_bloc.dart';

abstract class AiQueryEditedEvent {}

class AIQueryEditedInitialEvent extends AiQueryEditedEvent {
  final List<String>? selectedPipelineValue;
  final String? fildName;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  AIQueryEditedInitialEvent(
      {this.fildName,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipelineValue});
}
