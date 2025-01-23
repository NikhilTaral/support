part of 'ai_query_edited_bloc.dart';

abstract class AiQueryEditedEvent {}

class AIQueryEditedInitialEvent extends AiQueryEditedEvent {
  final List<String>? selectedPipelineValue;
  final String? fieldName;
  final DateTime? startDate;
  final DateTime? endDate;
  AIQueryEditedInitialEvent(
      {this.fieldName,
      this.startDate,
      this.endDate,
      this.selectedPipelineValue});
}
