part of 'ai_query_bloc.dart';

abstract class AiQueryEvent {}

class AIQueryInitialEvent extends AiQueryEvent {
  final List<String>? selectedPipelineValue;
  final String? fieldName;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? classificationFilterValue;
  AIQueryInitialEvent(
      {this.fieldName,
      this.selectedDate,
      this.selectedMonth,
      this.classificationFilterValue,
      this.selectedPipelineValue});
}
